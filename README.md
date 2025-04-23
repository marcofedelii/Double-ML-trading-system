# Advanced Trading DLLs – MT4 Integration

## Overview
This repository provides two proprietary DLLs designed to enhance algorithmic trading on MetaTrader 4 through external computation and modular architecture.

The libraries are:

- **`RFML.dll`** – Machine Learning Module
Implements a Random Forest classifier for trade prediction based on live market features.

- **`AMM.dll`** – Adaptive Money Management Module
Computes a dynamic risk multiplier using ensemble models (Random Forest + Linear Regression) to adjust trade exposure in real time.

Both DLLs are optimized for integration with Expert Advisors (EAs) and operate independently of the trading logic, ensuring separation of concerns and high modularity.

> ⚠️ **Note:** Source code is not included. Only the compiled DLLs are distributed in this repository.

## Features

- Real-time computation from external libraries
- Designed for low-latency environments (MetaTrader 4)
- Seamless integration with Expert Advisors via `import` directives
- Built-in error handling and default fallback values
- Supports high-frequency tick-based invocation

## Installation

1. Copy `RFML.dll` and `AMM.dll` into your terminal’s `MQL4/Libraries/` folder
2. Ensure your Expert Advisor is correctly importing the DLLs
3. Enable DLL imports from MetaTrader terminal settings
4. Restart MetaTrader 4

## Documentation

Documentation is provided in the `docs/` directory:

- `Doppio Motore ML per il trading ITA
- `Dual ML Engine for Algorithmic Trading: Forecasting and Dynamic Risk Management on MT4 ENG

Included:
- Input/output interface definitions
- Example usage in EAs
- Performance insights and constraints

## License

These DLLs are provided in compiled form only.

You may:
- Use them for **personal research** and **non-commercial trading** within MetaTrader 4

You may not:
- Reverse engineer, resell, or integrate into commercial products
- Distribute without prior written consent

Please refer to `LICENSE` for detailed legal terms.

Link for Volume Profile indicator:
https://github.com/marcofedelii/Volume-Profile-indicator

## Author

Developed by **Marco Fedeli**
Quantitative Trader & AI Architect
📧 Contact: marcofedeli05@icloud.com
