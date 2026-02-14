````markdown
# Brent-Kung Adder (Verilog HDL)

This repository contains a complete implementation of a **Brent-Kung Parallel Prefix Adder** using **Verilog HDL**. The Brent-Kung adder is a high-speed adder architecture that reduces carry propagation delay using a tree-based prefix structure, making it suitable for fast digital arithmetic circuits. The project includes all required modules such as **Generate/Propagate Logic**, **Carry Determination**, and **Sum Logic**, along with a full **testbench** for simulation and verification.

---

## 📌 Features

- Full Verilog implementation of **Brent-Kung Adder**
- Uses **Generate (G)** and **Propagate (P)** logic
- Parallel prefix tree carry computation
- Modular and organized design
- Includes complete testbench for verification
- Tested with random input vectors

---

## 📂 Project Files

| File Name | Description |
|----------|-------------|
| `Brent_Kung.v` | Top module of the Brent-Kung Adder |
| `GP_Logic.v` | Generate and Propagate logic module |
| `Carry_Determination.v` | Carry computation module |
| `Carry_Determination_Gonly.v` | Carry computation using Generate-only logic |
| `SUM_logic.v` | Sum calculation logic module |
| `Brent_Kung_tb.v` | Testbench for simulation and verification |

---

## ⚙️ Design Overview

The Brent-Kung Adder computes carries using a **parallel prefix structure**, which reduces delay compared to ripple-carry adders.

### Main Steps

1. Compute **Generate (G)** and **Propagate (P)** signals.
2. Use Brent-Kung prefix tree to compute carry signals.
3. Compute sum bits using: **S = P ⊕ C**

---

## 🧪 Simulation and Verification

The testbench `Brent_Kung_tb.v` applies multiple random test vectors for inputs **A**, **B**, and **Cin**, then compares the output result with the expected value computed using behavioral addition.

The simulation outputs:
- Input values: `A`, `B`, `Cin`
- Actual output from Brent-Kung Adder
- Correct output
- Pass/Fail result

---

## ▶️ How to Run

### Using ModelSim / QuestaSim

Compile all Verilog files:

```tcl
vlog Brent_Kung.v GP_Logic.v Carry_Determination.v Carry_Determination_Gonly.v SUM_logic.v Brent_Kung_tb.v
````

Run the simulation:

```tcl
vsim Brent_Kung_tb
run -all
```

---

### Using Icarus Verilog (iverilog)

Compile:

```bash
iverilog -o sim Brent_Kung.v GP_Logic.v Carry_Determination.v Carry_Determination_Gonly.v SUM_logic.v Brent_Kung_tb.v
```

Run:

```bash
vvp sim
```

---

## 📌 Example Output

```text
A = 2676093973088685431 , B = 1234567891234567890 , Cin = 0
Actual Result = 3910661864323253321
Correct Result = 3910661864323253321
Test Passed ✅
```

---

## 🛠️ Requirements

You can run this project using any Verilog simulator such as:

* ModelSim / QuestaSim
* Vivado Simulator
* Icarus Verilog
* Verilator

---

## 📚 Applications

Brent-Kung Adders are commonly used in:

* ALU (Arithmetic Logic Units)
* High-performance processors
* DSP systems
* FPGA and ASIC arithmetic circuits

---

## 👨‍💻 Author

**George Jan George**
Digital Design Engineer | FPGA Developer | Verilog & SystemVerilog Enthusiast

---

## 📜 License

This project is open-source and available for learning and educational purposes. Feel free to use, modify, and improve it.


