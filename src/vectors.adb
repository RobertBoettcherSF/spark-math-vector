--  SPARK Vector Library - Main Package Body
--  Version: 0.05

with Ada.Numerics.Generic_Elementary_Functions;

package body Vectors with
  SPARK_Mode => On
is
   -- Version 0.05
   
   -- Instantiate elementary functions for Real type
   package Real_Functions is new Ada.Numerics.Generic_Elementary_Functions (Real);
   
   -- Generic N-dimensional vector operations
   generic
      Dimension : Positive;
   package body N_Dimensional_Vectors is
      
      -- Vector addition
      function "+" (Left, Right : Vector) return Vector is
         Result : Vector;
      begin
         for I in 1 .. Dimension loop
            Result(I) := Left(I) + Right(I);
            pragma Loop_Invariant (for all J in 1 .. I-1 => Result(J) = Left(J) + Right(J));
         end loop;
         return Result;
      end "+";
      
      -- Scalar multiplication
      function "*" (Scalar : Real; Vec : Vector) return Vector is
         Result : Vector;
      begin
         for I in 1 .. Dimension loop
            Result(I) := Scalar * Vec(I);
            pragma Loop_Invariant (for all J in 1 .. I-1 => Result(J) = Scalar * Vec(J));
         end loop;
         return Result;
      end "*";
      
      -- Dot product (Skalarprodukt)
      function Dot_Product (Left, Right : Vector) return Real is
         Sum : Real := 0.0;
      begin
         for I in 1 .. Dimension loop
            Sum := Sum + Left(I) * Right(I);
         end loop;
         return Sum;
      end Dot_Product;
      
      -- Norm (Euclidean) - SPARK proof for numerical stability
      -- No division by zero possible as we only use multiplication and addition
      function Norm (Vec : Vector) return Real is
         Sum_Squares : Real := 0.0;
      begin
         for I in 1 .. Dimension loop
            Sum_Squares := Sum_Squares + Vec(I) ** 2;
         end loop;
         
         -- Square root is always defined for non-negative numbers
         -- Sum_Squares is always >= 0.0 due to squaring
         return Real_Functions.Sqrt(Sum_Squares);
      end Norm;
      
      -- Cross product for 3D vectors only
      -- Precondition ensures Dimension = 3, preventing invalid access
      function Cross_Product (Left, Right : Vector) return Vector is
         Result : Vector;
      begin
         -- SPARK will verify these indices are valid due to Pre => Dimension = 3
         Result(1) := Left(2) * Right(3) - Left(3) * Right(2);
         Result(2) := Left(3) * Right(1) - Left(1) * Right(3);
         Result(3) := Left(1) * Right(2) - Left(2) * Right(1);
         return Result;
      end Cross_Product;
      
   end N_Dimensional_Vectors;

end Vectors;
