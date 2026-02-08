# ⚡ Smart Grid — MPC-Based Battery Control  
MATLAB/Simulink Implementation for Microgrid Frequency Stabilization

This repository implements a **Model Predictive Control (MPC)** strategy to regulate frequency in a **low-inertia microgrid** using a **Battery Energy Storage System (BESS)**.  
The project compares classical droop control with predictive control and demonstrates how MPC improves dynamic response, constraint handling, and robustness under load and PV disturbances.

---

# 🌍 Project Context

Modern microgrids face challenges due to:

- High renewable penetration  
- Reduced rotational inertia  
- Fast load and PV fluctuations  
- Limited generator flexibility  

This project applies MPC to maintain grid frequency near **50 Hz**, respecting constraints and anticipating disturbances.

---

# 🧩 Microgrid Architecture

The simulated microgrid consists of:

- Synchronous Generator (droop baseline)  
- Battery Energy Storage System (BESS)  
- PV Generation  
- Variable Load  
- Centralized MPC Controller  

![Microgrid Diagram](figures/sistema%20(1).png)

---

# 🧠 Control Strategy

### Frequency Dynamics

$$
2H' \frac{d(\Delta f)}{dt} = P_{bat} - (P_{load} - P_{PV})
$$

### State-Space Model

$$
\dot{x} = Ax + Bu, \qquad y = x
$$

**State**

$$
x = \Delta f
$$

**Inputs**

$$
u = [P_{bat},\; P_{load},\; P_{PV}]^{T}
$$

---

# 🔧 MPC Configuration

- **Sampling Time:** 1 s  
- **Prediction Horizon:** 360 s  
- **Control Horizon:** 20 s  

- **Constraints:**

$$
-50 \le P_{bat} \le 50
$$

- **Ramp Rate Limit:** ±5 kW/s  
- **Controller Weights:**  
  - Output tracking: 100  
  - Input effort: 0.1  
  - Rate of change: 1  

![MPC Block](figures/mpcBloco%20(1).png)

---

# 📈 Key Results

## 🔵 Frequency Response — Droop vs MPC

MPC stabilizes frequency faster, with less overshoot and better damping.

| Droop Control | MPC Control |
|--------------|-------------|
| ![Droop](figures/result%20droop%20(1).png) | ![MPC](figures/result%20mpc%20(1).png) |

# 📘 Documentation

Full technical report available at:

[Smart_Grid_EN.pdf](docs/Smart_Grid_EN.pdf)

---

# 👤 Authors

**Ioglas Alves da Fonseca**  
**Bruno Nascimento Brasilino de Freitas**  
École Centrale de Lille — Smart Grid Project




