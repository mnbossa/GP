import Numeric.LinearAlgebra

type DVector = Vector Double
type DMatrix = Matrix Double

type CovarianceMatrix = Matrix Double
type Kernel = DVector -> DVector -> CovarianceMatrix 

rbf :: Double -> Kernel
rbf k x y = exp $ -((asColumn x - asRow y) / scalar k )^2

genSamplesSimple :: DVector -> Kernel -> IO DVector
genSamplesSimple x k = do
  r <- randn n 1 -- also see multivariate normal: gaussianSample
  return $ flatten (tr l <> r)
  where
    n = size x
    l = chol . sym $ k x x + ident n * 1e-8
