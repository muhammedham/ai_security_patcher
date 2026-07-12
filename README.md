# 🛡️ AI Security Patcher

**AI Security Patcher** is a cutting-edge DevSecOps Flutter application designed to act as an AI Copilot for Application Security Engineers. Powered by the latest **Gemini 3.5 Flash** model, it intelligently analyzes raw source code and container security logs (e.g., Trivy, OWASP) to detect vulnerabilities and provide actionable, step-by-step patching workflows.

---

## ✨ Key Features

* **🔍 Intelligent Vulnerability Scanning:** Paste code snippets or security logs directly into the workspace for instant analysis.
* **🛠️ Automated Patching Workflow:** Generates precise, step-by-step remediation strategies tailored to the specific vulnerability.
* **📊 Markdown-Rendered Reports:** Delivers professional, easy-to-read security audit reports with syntax-highlighted code blocks (Vulnerable vs. Secure).
* **🔐 Secure API Key Storage:** Utilizes `flutter_secure_storage` to encrypt and store the user's Gemini API key locally, ensuring zero credential leakage.
* **🎨 Cyberpunk/Hacker UI:** A sleek, dark-themed interface built with `Google Fonts` (Orbitron & JetBrains Mono) for an immersive DevSecOps experience.

---

## 🛠️ Tech Stack

* **Framework:** Flutter
* **Language:** Dart
* **State Management:** Provider
* **AI Integration:** Google Generative AI (`gemini-3.5-flash`)
* **Local Storage:** Flutter Secure Storage
* **UI Components:** Flutter Markdown, Google Fonts

---

## 🚀 Getting Started

### Prerequisites
* Flutter SDK installed on your machine.
* A valid [Google Gemini API Key](https://aistudio.google.com/app/apikey).

### Installation
1. Clone the repository:
   ```bash
   git clone [https://github.com/USERNAME/ai_security_patcher.git](https://github.com/USERNAME/ai_security_patcher.git)