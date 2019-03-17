# nand2tetris
## Project 1 : Logic Gates

The goal of this project is to create form the `Nand` gate, 16 basic gates
that we will use in order to build our computer.

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

In order to build our ALU, we first build a `Half Adder` with a `And` and a
`Xor` gate, that takes a and b as an input and yields the sum and the carry
as an output. From there, we can build a `Full Adder` and then a `16-bit Adder`.

Then, based on those chips, whe can build the ALU. It has the following inputs :
* `x` and `y` 16-bits inputs that represent the data on which you want to operate.
* `zx`, `nx`, `zy`, `ny`, `f` and `no` which are the control bits of the ALU
  * `zx` stands for `zero x`
  * `nx` stands for `not x`
  * `zy` stands for `zero y`
  * `ny` stands for `non y`
  * `f` adds the transformed x and y if f is 1 or perform an And operation otherwise
  * `no` negates the output

It has the following outputs :
* `out` the 16-bits output
* `zr` true if out = 0
* `ng` true if out < 0

Using those 6 control bits wisely, we are able to perform the following operations :

| zx  | nx  | zy  | ny  | f   | no  |out  |
| --- | --- | --- | --- | --- | --- | --- |
| 1   | 0   | 1   | 0   | 1   | 0   | 0   |
| 1   | 1   | 1   | 1   | 1   | 1   | 1   |
| 1   | 1   | 1   | 0   | 1   | 0   | -1  |
| 0   | 0   | 1   | 1   | 0   | 0   | x   |
| 1   | 1   | 0   | 0   | 0   | 0   | y   |
| 0   | 0   | 1   | 1   | 0   | 1   | !x  |
| 1   | 1   | 0   | 0   | 0   | 1   | !y  |
| 0   | 0   | 1   | 1   | 1   | 1   | -x  |
| 1   | 1   | 0   | 0   | 1   | 1   | -y  |
| 0   | 1   | 1   | 1   | 1   | 1   | x+1 |
| 1   | 1   | 0   | 1   | 1   | 1   | y+1 |
| 0   | 0   | 1   | 1   | 1   | 0   | x-1 |
| 1   | 1   | 0   | 1   | 0   | 0   | y-1 |
| 0   | 0   | 0   | 0   | 1   | 0   | x+y |
| 0   | 1   | 0   | 0   | 1   | 1   | x-y |
| 0   | 0   | 0   | 1   | 1   | 1   | y-x |
| 0   | 0   | 0   | 0   | 0   | 0   | x&y |
| 0   | 1   | 0   | 1   | 0   | 1   | x|y |

We finish this project by building an incrementer which performs the simple task
out = in + 1.

## Project 3 : RAM and counter

The goal of the project is to create a 1 bit register, a 16 bit register,
all sorts of RAM chips and a counter based on the chips from previous chapters
and a Data Flip Flop (DFF) gate. The DFF gate is a simple gate that receives a
signal a repeats it one time unit after it received is `out(t+1) = in(t)`.
Based on this DFF, it is possible to build a 1-bit register (a gate that stores
only one bit) using a multiplexor and a DFF. Is is then possible to build a 16-bit
register.

It is now possible to build a RAM8 which takes as an input `in[16]`, `load`, and
`address[3]` and outputs the value of the selected register.
This RAM8 chip is a memory of 8 registers, each 16 bit-wide. It
holds the value stored at the memory location specified by address.
It is possible to store data using the load bit.
From there, it is possible to build all types of memories of different size.

At the end of the project, we also build a `Program Counter` (PC) :
A 16-bit counter with load and reset control bits.
 * if      (reset[t] == 1) out[t+1] = 0
 * else if (load[t] == 1)  out[t+1] = in[t]
 * else if (inc[t] == 1)   out[t+1] = out[t] + 1  (integer addition)
 * else                    out[t+1] = out[t]

## Project 4 : Machine language

In Hack machine language, there are two sort of instructions :
* A instructions which are used to select an address in the RAM (@12)
* C instructions used to perform a simple operation (D; JGT)

**A instructions**
The A-instruction is used to set the A register to a 15-bit value.
It's binary representation is 0vvv vvvv vvvv vvvv.

**C instructions**
The C-instruction is the programming workhorse of the Hack platform.
The instruction code is a specification that answers three questions :

1. What to compute ?
2. Where to store the result ?
3. What to do next ?

Its binary representation is 111 a cccccc ddd jjj.

It starts with 1 by convention, then 11 also by convention because we are not
going to use those 2 bits.

Then, a and cccccc allows us to perform the following operations (computation part) :

| a=0 | c1  | c2  | c3  | c4  | c5  | c6  | a=1 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 0   | 1   | 0   | 1   | 0   | 1   | 0   |     |
| 1   | 1   | 1   | 1   | 1   | 1   | 1   |     |
| -1  | 1   | 1   | 1   | 0   | 1   | 0   |     |
| D   | 0   | 0   | 1   | 1   | 0   | 0   |     |
| A   | 1   | 1   | 0   | 0   | 0   | 0   | M   |
| !D  | 0   | 0   | 1   | 1   | 0   | 1   |     |
| !A  | 1   | 1   | 0   | 0   | 0   | 1   | !M  |
| -D  | 0   | 0   | 1   | 1   | 1   | 1   |     |
| -A  | 1   | 1   | 0   | 0   | 1   | 1   | -M  |
| D+1 | 0   | 1   | 1   | 1   | 1   | 1   |     |
| A+1 | 1   | 1   | 0   | 1   | 1   | 1   | M+1 |
| D-1 | 0   | 0   | 1   | 1   | 1   | 0   |     |
| A-1 | 1   | 1   | 0   | 0   | 1   | 0   | M-1 |
| D+A | 0   | 0   | 0   | 0   | 1   | 0   | D+M |
| D-A | 0   | 1   | 0   | 0   | 1   | 1   | D-M |
| A-D | 0   | 0   | 0   | 1   | 1   | 1   | M-D |
| D&A | 0   | 0   | 0   | 0   | 0   | 0   | D&M |
| D|A | 0   | 1   | 0   | 1   | 0   | 1   | D|M |

D and A are names of registers. M refers to the memory location addressed by A,
namely, to Memory[A].

Then the destination part is used to know where to store the information according
to the following table :

| d1  | d2  | d3  | destination |
| --- | --- | --- | ----------- |
| 0   | 0   | 0   | null        |
| 0   | 0   | 1   | M           |
| 0   | 1   | 0   | D           |
| 0   | 1   | 1   | MD          |
| 1   | 0   | 0   | A           |
| 1   | 0   | 1   | AM          |
| 1   | 1   | 0   | AD          |
| 1   | 1   | 1   | AMD         |

Then the jump part is used to know which instuction should be executed after
according to the following table :

| d1  | d2  | d3  | effect           |
| --- | --- | --- | ---------------- |
| 0   | 0   | 0   | no jump          |
| 0   | 0   | 1   | jump if out > 0  |
| 0   | 1   | 0   | jump if out = 0  |
| 0   | 1   | 1   | jump if out >= 0 |
| 1   | 0   | 0   | jump if out < 0  |
| 1   | 0   | 1   | jump if out != 0 |
| 1   | 1   | 0   | jump if out <= 0 |
| 1   | 1   | 1   | jump             |

**Syntaxic sugar**

It is possible to declare variables that refers to some memory location using
for example @sum or @i

It is possible to declare some labels for example @END and later in the code (END).
Such labels are used in order to be easier tu remember lines of the machine
language program. For example :

```
@LOOP
0;JMP
```

means go to the (LOOP) label line instead of specifing the number of the line.

Also the I/O pointers SCREEN and KBD are defined to refer to memory location 16348
and 24576 (beginning of the screen memory map and beginning of the keyboard memory
map).
