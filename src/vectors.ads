--  SPARK Vector Library - Generic N-dimensional vectors with mathematical operations
--  Purpose: Foundation for physics, chemistry, and graphics applications
--  Demonstrates safe mathematical type implementation in SPARK
--  Version: 0.05

package Vectors with
  SPARK_Mode => On
is
   -- Version 0.05
   
   type Real is digits 15 range -1.0E300 .. 1.0E300;
   
   -- Generic N-dimensional vector type
   generic
      Dimension : Positive;
   package N_Dimensional_Vectors is
      
      type Vector is array (1 .. Dimension) of Real;
      
      -- Vector addition
      function "+" (Left, Right : Vector) return Vector;
      
      -- Scalar multiplication
      function "*" (Scalar : Real; Vec : Vector) return Vector;
      
      -- Dot product (Skalarprodukt)
      function Dot_Product (Left, Right : Vector) return Real;
      
      -- Norm (Euclidean)
      function Norm (Vec : Vector) return Real
        with
          Pre => True,
          Post => Norm'Result >= 0.0 and then
                  Norm'Result ** 2 = Dot_Product(Vec, Vec);
      
      -- Cross product for 3D vectors only
      function Cross_Product (Left, Right : Vector) return Vector
        with
          Pre => Dimension = 3,
          Post => (for all I in 1 .. 3 =>
                     (I = 1 and then Cross_Product'Result(I) = Left(2) * Right(3) - Left(3) * Right(2)) or
                     (I = 2 and then Cross_Product'Result(I) = Left(3) * Right(1) - Left(1) * Right(3)) or
                     (I = 3 and then Cross_Product'Result(I) = Left(1) * Right(2) - Left(2) * Right(1)));
      
   end N_Dimensional_Vectors;

   -- Convenience packages for common dimensions
   package Vector_2D is new N_Dimensional_Vectors (Dimension => 2);
   package Vector_3D is new N_Dimensional_Vectors (Dimension => 3);

end Vectors;
