# nand2tetris
## Project 1 : Logic Gates

This is an example of HDL code :

#### For a simple Chip

```
Chip Xor {
  IN a, b;
  OUT out;

  PARTS:

  Not(in=a, out=nota);
  Not(in=b, out=notb);
  And(a=a, b=notb, out=aAndNotb);
  And(a=nota, b=b, out=notaAndb);
  Or(a=aAndNotb, b=notaAndb, out=out);
}
```

#### For a chip with multiple inputs (buses)

Inputs are represented as an array here where the index 0 is the least important
bit.

```
Chip Add3Way16 {
  IN first[16], second[16], third[16];
  OUT out[16];

  PARTS:

  Add16(a=first, b=second, out=temp);
  Add16(a=temp, b=third, out=out);
}
```

or

```
Chip And4Way {
  IN a[4];
  OUT out;

  PARTS:

  And(a=a[0], b=a[1], out=t01);
  And(a=t01, b=a[2], out=t012);
  And(a=t012, b=a[3], out=out);
}
```

or

```
Chip And4 {
  IN a[4], b[4];
  OUT out[4];

  PARTS:
  And(a=a[0], b=b[0], out=out[0]);
  And(a=a[1], b=b[1], out=out[1]);
  And(a=a[2], b=b[2], out=out[2]);
  And(a=a[3], b=b[3], out=out[3]);
}
```

## Project 2 : ALU

The goal of the project is to create an Arithmetic Logic Unit from scratch.

## Project 3 : RAM an counter

The goal of the project is to create a 1 bit register, a 16 bit register,
all sorts of RAM chips and a counter based on the chips from previous chapters
and a Data Flip Flop (DFF) gate.
