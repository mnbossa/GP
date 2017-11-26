import Numeric.LinearAlgebra
import Gp00
 
compPosterior :: DVector -> DMatrix -> Kernel -> DMatrix -> Double 
                     -> (DVector, DMatrix, Double)
compPosterior y x k x' snoise = (f, vf, log_p) 
  where n     = fst . size $ x
        kxx'  = k x x'
        l     =  tr $ chol . sym $ k x x + ident n * scalar (snoise + 1e-8)
        alpha = triSolve Upper (tr l) $ triSolve Lower l (asColumn y)
        f     = flatten $ tr kxx' <> alpha
        v     = triSolve Lower l kxx'
        vf    = k x' x' - tr v <> v
        log_p = - 0.5* y <.> flatten alpha -  0.5*fromIntegral n * log (2*pi) 
                - (sumElements . log . takeDiag ) l 

genSamples :: DMatrix -> DVector -> DMatrix -> IO DVector 
genSamples x m k = do
   r <- randn n 1 
   return $ m + flatten (tr l <> r)
   where n = fst . size $ x
         l = chol . sym $ k + ident n * 1e-8

