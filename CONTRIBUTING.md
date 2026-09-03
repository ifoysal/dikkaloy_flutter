# Contributing to Dikkhaloy Flutter

Thank you for your interest in contributing to **Dikkhaloy**, developed and maintained by **[Nothibazar](https://nothibazar.com.bd)**.

## 🤝 Code of Conduct

All contributors are expected to uphold a welcoming, respectful, and productive collaboration environment.

## 🛠️ Development Workflow

1. **Branching Strategy**:
   - `main`: Production-ready code.
   - `develop` / `feature/*`: Active development and new features.
   - `fix/*`: Bug fixes and patches.

2. **Code Style & Standards**:
   - Follow standard Dart and Flutter formatting (`dart format .`).
   - Adhere to `flutter_lints` configurations defined in `analysis_options.yaml`.
   - Maintain Clean Architecture separation between data, domain, and presentation layers.
   - Use Riverpod state notifiers and generators (`build_runner`) for state management.

3. **Running Checks**:
   Before submitting any Pull Request, ensure that all tests and lint checks pass cleanly:
   ```bash
   dart format --set-exit-if-changed .
   flutter analyze
   flutter test
   ```

4. **Submitting Changes**:
   - Write clear, conventional commit messages (e.g., `feat(mcq): add question timer animation`, `fix(auth): handle token expiration`).
   - Create a Pull Request with a clear summary of changes and testing steps.

---

Developed and Maintained by **[Nothibazar](https://nothibazar.com.bd)**.
