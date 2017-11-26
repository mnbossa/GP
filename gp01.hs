import Numeric.LinearAlgebra
import Gp00
 
genSamplesSimple :: DMatrix -> Kernel -> IO DVector
genSamplesSimple x k = do
  r <- randn n 1 -- also see multivariate normal: gaussianSample
  return $ flatten (tr l <> r)
  where n = fst . size $ x
        l = chol . sym $ k x x + ident n * 1e-8
