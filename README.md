# ⚡ Smart Grid — MPC-Based Battery Control  
MATLAB/Simulink Implementation for Microgrid Frequency Stabilization

This repository implements a **Model Predictive Control (MPC)** strategy to regulate frequency in a **low-inertia microgrid** using a **Battery Energy Storage System (BESS)**.  
The project compares classical droop control with predictive control and demonstrates how MPC improves dynamic response, constraint handling, and robustness under load and PV disturbances.

---

# 🌍 Project Context

Modern microgrids face challenges due to:

- High renewable penetration  
- Reduced rotational inertia  
- Fast load/PV fluctuations  
- Limited generator flexibility  

To address this, a predictive and constraint-aware battery controller is applied to maintain grid frequency near **50 Hz**.

---

# 🧩 Microgrid Architecture

The simulated microgrid includes:

- Synchronous Generator (droop baseline)  
- Battery Energy Storage System (BESS)  
- Photovoltaic array (PV)  
- Variable Load  
- Centralized MPC Controller  

![Microgrid Diagram](figures/sistema.png)

---

# 🧠 Control Strategy

### Frequency Dynamics

$$
2H' \frac{d(\Delta f)}{dt} = P_{bat} - (P_{load} - P_{PV})
$$

### State-Space Form

$$
\dot{x} = Ax + Bu, \qquad y = x
$$

Where:

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

![MPC Block](figures/mpcBloco.png)

---

# 📈 Key Results

## 🔵 Frequency Response — Droop vs MPC

MPC stabilizes frequency faster, with lower overshoot and improved damping.

| Droop Control | MPC Control |
|--------------|-------------|
| ![Droop](figures/result_droop.png) | ![MPC](figures/result_mpc.png) |

---

# 📘 Documentation

Full technical report available in:

📄 `/docs/Smart_Grid_EN.pdf`

---

# 👤 Authors

**Ioglas Alves da Fonseca**  
**Bruno Nascimento Brasilino de Freitas**  
École Centrale de Lille — Smart Grid Project



