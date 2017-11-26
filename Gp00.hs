module Gp00 where
import Numeric.LinearAlgebra

type DVector = Vector Double
type DMatrix = Matrix Double
type CovarianceMatrix = Matrix Double
type Kernel = DMatrix -> DMatrix -> CovarianceMatrix 

sumElems :: DVector -> Double
sumElems = sumElements 

rbf :: Double -> Kernel
rbf l xm ym = exp $ - (len xm >< len ym) [d x y | x <- toRows xm, y <- toRows ym ] 
  where d a b = sumElems $ (( a - b ) / scalar l)^2
        len   = fst . size
-- forDVectors: rbf l x y = exp $ -((asColumn x - asRow y) / scalar l )^2
