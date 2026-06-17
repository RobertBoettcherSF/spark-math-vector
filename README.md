# SPARK Vector Library

A **minimal**, **generic** N-dimensional vector library for **Ada SPARK** with mathematical operations and formal proofs for numerical stability.

-- Version: 0.02

## Purpose

Foundation for physics, chemistry, and graphics applications. Demonstrates how to safely implement mathematical types in SPARK with:

- **Type safety** through generic packages
- **Numerical stability** proofs (no division by zero)
- **Formal verification** of mathematical properties

## Features

### Vector Types
- **Generic N-dimensional**: `N_Dimensional_Vectors(Dimension => N)`
- **2D vectors**: `Vector_2D` (pre-instantiated)
- **3D vectors**: `Vector_3D` (pre-instantiated)

### Operations
- **Addition**: `Vector + Vector`
- **Scalar multiplication**: `Real * Vector`
- **Dot product**: `Dot_Product(Vector, Vector)`
- **Norm**: `Norm(Vector)` (Euclidean)
- **Cross product**: `Cross_Product(Vector, Vector)` (3D only)

### SPARK Proofs
- **No division by zero**: All operations use only addition, multiplication, and square root
- **Preconditions**: Cross product requires `Dimension = 3`
- **Postconditions**: Mathematical correctness verified for all operations

## Usage

```ada
with Vectors;

procedure Example is
   use Vectors;
   
   -- 2D vector operations
   V1 : Vector_2D.Vector := (1.0, 2.0);
   V2 : Vector_2D.Vector := (3.0, 4.0);
   Sum : Vector_2D.Vector := V1 + V2;
   Dot : Real := Vector_2D.Dot_Product(V1, V2);
   
   -- 3D vector operations
   V3 : Vector_3D.Vector := (1.0, 0.0, 0.0);
   V4 : Vector_3D.Vector := (0.0, 1.0, 0.0);
   Cross : Vector_3D.Vector := Vector_3D.Cross_Product(V3, V4);
   
   -- Norm calculation
   Length : Real := Vector_3D.Norm(V3);
begin
   null;
end Example;
```

## Files

- `src/vectors.ads` - Specification with contracts (Version: 0.02)
- `src/vectors.adb` - Main package body (Version: 0.02)
- `src/vectors-n_dimensional_vectors.adb` - N-Dimensional vectors implementation (Version: 0.02)
- `vectors.gpr` - GNAT Project file for gnatprove (Version: 0.02)

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

1. **Generic dimension**: Single implementation works for any dimension
2. **Type safety**: Each dimension has its own type
3. **Numerical stability**: Only uses operations that are always defined
4. **Formal proofs**: SPARK verifies all contracts automatically
5. **Structure**: Uses child package `Vectors.N_Dimensional_Vectors` for the generic implementation
