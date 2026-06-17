# SPARK Vector Library

A **minimal** vector library for **Ada SPARK** with mathematical operations and formal proofs for numerical stability.

-- Version: 0.07

## Purpose

Foundation for physics, chemistry, and graphics applications. Demonstrates how to safely implement mathematical types in SPARK with:

- **Type safety** through distinct 2D and 3D vector types
- **Numerical stability** proofs (no division by zero)
- **Formal verification** of mathematical properties

## Features

### Vector Types
- **2D vectors**: `Vector_2D` (array 1..2 of Real)
- **3D vectors**: `Vector_3D` (array 1..3 of Real)

### Operations
- **Addition**: `Vector_2D + Vector_2D`, `Vector_3D + Vector_3D`
- **Scalar multiplication**: `Real * Vector_2D`, `Real * Vector_3D`
- **Dot product**: `Dot_Product(Vector_2D, Vector_2D)`, `Dot_Product(Vector_3D, Vector_3D)`
- **Norm**: `Norm(Vector_2D)`, `Norm(Vector_3D)` (Euclidean)
- **Cross product**: `Cross_Product(Vector_3D, Vector_3D)` (3D only)

### SPARK Proofs
- **No division by zero**: All operations use only addition, multiplication, and square root
- **Preconditions**: All operations have True preconditions (always safe)
- **Postconditions**: Mathematical correctness verified for Norm and Cross_Product
- **Loop invariants**: Added for vector addition and scalar multiplication

## Usage

```ada
with Vectors;

procedure Example is
   use Vectors;
   
   -- 2D vector operations
   V1 : Vector_2D := (1.0, 2.0);
   V2 : Vector_2D := (3.0, 4.0);
   Sum : Vector_2D := V1 + V2;
   Dot : Real := Dot_Product(V1, V2);
   Length : Real := Norm(V1);
   
   -- 3D vector operations
   V3 : Vector_3D := (1.0, 0.0, 0.0);
   V4 : Vector_3D := (0.0, 1.0, 0.0);
   Cross : Vector_3D := Cross_Product(V3, V4);
   
begin
   null;
end Example;
```

## Files

- `src/vectors.ads` - Specification with contracts (Version: 0.07)
- `src/vectors.adb` - Implementation with proofs (Version: 0.07)
- `vectors.gpr` - GNAT Project file for gnatprove (Version: 0.07)

## Verification

To verify with SPARK:

```bash
# Using gnatprove with the project file
gnatprove -P vectors.gpr --level=4 --timeout=0 --no-inlining --report=all --verbose
```

All operations are proven to be:
- **Total**: No runtime errors (no division by zero)
- **Correct**: Mathematical properties verified via postconditions
- **Safe**: Array bounds checked by SPARK

## Design Notes

1. **Simplified approach**: Uses concrete 2D and 3D vector types instead of generics
2. **Type safety**: Each dimension has its own distinct type
3. **Numerical stability**: Only uses operations that are always defined
4. **Formal proofs**: SPARK verifies all contracts automatically
