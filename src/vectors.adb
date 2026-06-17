--  SPARK Vector Library - Vector operations implementation
--  Version: 0.07

with Ada.Numerics.Generic_Elementary_Functions;

package body Vectors with
  SPARK_Mode => On
is
   -- Version 0.07
   
   -- Instantiate elementary functions for Real type
   package Real_Functions is new Ada.Numerics.Generic_Elementary_Functions (Real);
   
   -- Vector addition for 2D
   function "+" (Left, Right : Vector_2D) return Vector_2D is
      Result : Vector_2D;
   begin
      for I in 1 .. 2 loop
         Result(I) := Left(I) + Right(I);
         pragma Loop_Invariant (for all J in 1 .. I-1 => Result(J) = Left(J) + Right(J));
      end loop;
      return Result;
   end "+";
   
   -- Vector addition for 3D
   function "+" (Left, Right : Vector_3D) return Vector_3D is
      Result : Vector_3D;
   begin
      for I in 1 .. 3 loop
         Result(I) := Left(I) + Right(I);
         pragma Loop_Invariant (for all J in 1 .. I-1 => Result(J) = Left(J) + Right(J));
      end loop;
      return Result;
   end "+";
   
   -- Scalar multiplication for 2D
   function "*" (Scalar : Real; Vec : Vector_2D) return Vector_2D is
      Result : Vector_2D;
   begin
      for I in 1 .. 2 loop
         Result(I) := Scalar * Vec(I);
         pragma Loop_Invariant (for all J in 1 .. I-1 => Result(J) = Scalar * Vec(J));
      end loop;
      return Result;
   end "*";
   
   -- Scalar multiplication for 3D
   function "*" (Scalar : Real; Vec : Vector_3D) return Vector_3D is
      Result : Vector_3D;
   begin
      for I in 1 .. 3 loop
         Result(I) := Scalar * Vec(I);
         pragma Loop_Invariant (for all J in 1 .. I-1 => Result(J) = Scalar * Vec(J));
      end loop;
      return Result;
   end "*";
   
   -- Dot product for 2D
   function Dot_Product (Left, Right : Vector_2D) return Real is
      Sum : Real := 0.0;
   begin
      for I in 1 .. 2 loop
         Sum := Sum + Left(I) * Right(I);
      end loop;
      return Sum;
   end Dot_Product;
   
   -- Dot product for 3D
   function Dot_Product (Left, Right : Vector_3D) return Real is
      Sum : Real := 0.0;
   begin
      for I in 1 .. 3 loop
         Sum := Sum + Left(I) * Right(I);
      end loop;
      return Sum;
   end Dot_Product;
   
   -- Norm for 2D - SPARK proof for numerical stability
   function Norm (Vec : Vector_2D) return Real is
      Sum_Squares : Real := 0.0;
   begin
      for I in 1 .. 2 loop
         Sum_Squares := Sum_Squares + Vec(I) ** 2;
      end loop;
      return Real_Functions.Sqrt(Sum_Squares);
   end Norm;
   
   -- Norm for 3D - SPARK proof for numerical stability
   function Norm (Vec : Vector_3D) return Real is
      Sum_Squares : Real := 0.0;
   begin
      for I in 1 .. 3 loop
         Sum_Squares := Sum_Squares + Vec(I) ** 2;
      end loop;
      return Real_Functions.Sqrt(Sum_Squares);
   end Norm;
   
   -- Cross product for 3D only
   function Cross_Product (Left, Right : Vector_3D) return Vector_3D is
      Result : Vector_3D;
   begin
      Result(1) := Left(2) * Right(3) - Left(3) * Right(2);
      Result(2) := Left(3) * Right(1) - Left(1) * Right(3);
      Result(3) := Left(1) * Right(2) - Left(2) * Right(1);
      return Result;
   end Cross_Product;

end Vectors;
