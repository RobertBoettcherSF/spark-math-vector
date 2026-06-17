--  SPARK Vector Library - Vector types and operations
--  Purpose: Foundation for physics, chemistry, and graphics applications
--  Demonstrates safe mathematical type implementation in SPARK
--  Version: 0.07

package Vectors with
  SPARK_Mode => On
is
   -- Version 0.07
   
   type Real is digits 15 range -1.0E300 .. 1.0E300;
   
   -- 2D Vector type
   type Vector_2D is array (1 .. 2) of Real;
   
   -- 3D Vector type
   type Vector_3D is array (1 .. 3) of Real;
   
   -- Vector addition for 2D
   function "+" (Left, Right : Vector_2D) return Vector_2D;
   
   -- Vector addition for 3D
   function "+" (Left, Right : Vector_3D) return Vector_3D;
   
   -- Scalar multiplication for 2D
   function "*" (Scalar : Real; Vec : Vector_2D) return Vector_2D;
   
   -- Scalar multiplication for 3D
   function "*" (Scalar : Real; Vec : Vector_3D) return Vector_3D;
   
   -- Dot product for 2D
   function Dot_Product (Left, Right : Vector_2D) return Real;
   
   -- Dot product for 3D
   function Dot_Product (Left, Right : Vector_3D) return Real;
   
   -- Norm for 2D
   function Norm (Vec : Vector_2D) return Real
     with
       Pre => True,
       Post => Norm'Result >= 0.0 and then
               Norm'Result ** 2 = Dot_Product(Vec, Vec);
   
   -- Norm for 3D
   function Norm (Vec : Vector_3D) return Real
     with
       Pre => True,
       Post => Norm'Result >= 0.0 and then
               Norm'Result ** 2 = Dot_Product(Vec, Vec);
   
   -- Cross product for 3D only
   function Cross_Product (Left, Right : Vector_3D) return Vector_3D
     with
       Pre => True,
       Post => Cross_Product'Result(1) = Left(2) * Right(3) - Left(3) * Right(2) and
               Cross_Product'Result(2) = Left(3) * Right(1) - Left(1) * Right(3) and
               Cross_Product'Result(3) = Left(1) * Right(2) - Left(2) * Right(1);

end Vectors;
