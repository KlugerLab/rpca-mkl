require(fastRPCA)

testDim <- c(10E1, 10E2)
for (m in testDim){
    for (n in testDim){
        for (centering in c(0,1,2)){
            k_ <- 20;
            m <- testDim[1]
            n <- testDim[2]
            centering <- 0
            B <- matrix(rexp(m*k_), m)
            C <- matrix(rexp(k_*n), k_)
            D <- B %*%C;
            if (centering == 0 ){
                rowCentering_ <- FALSE;
                colCentering_ <- FALSE;
                Dt <- D;
            }else if (centering ==1){
                rowCentering_ <- TRUE;
                colCentering_ <- FALSE;
                Dt <- t(scale(t(D), center=TRUE, scale=FALSE));
            }else {
                rowCentering_ <- FALSE;
                colCentering_ <- TRUE;
                Dt <- scale(D, center=TRUE, scale=FALSE);
            }

            dim(D)
            fastDecomp <- fastPCA(D, k=k_, diffsnorm=TRUE)
            diffNorm <- norm(Dt - fastDecomp$U %*% fastDecomp$S %*%t(fastDecomp$V), type='2')
            if ( diffNorm > 1E-9){
                stop (sprintf("Test Failed: m: %d, n: %d, k: %d", fastDecomp$dim[0], fastDecomp[1], k_))
            }else{
                message("Passed test")
            }
        }
    }
}
