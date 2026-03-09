# Project Instructions — Data Science / ML Project
# Stack: Python + Jupyter + Pandas + scikit-learn
# Customize this template. Delete sections that don't apply.

# ============================================================
# This file runs every turn. Keep it lean. Rules, not essays.
# ============================================================

## Project Context
This is [PROJECT NAME] — [one-sentence description of what it does].
Stack: Python 3.11+, Jupyter notebooks, Pandas, NumPy, scikit-learn, matplotlib/seaborn.
Data stored in [S3 / GCS / local]. Models tracked with [MLflow / Weights & Biases / local].

## Rules

### Verification
- **Verify before claiming done.** Run `python -m pytest` for utility functions. Show the output.
- **Notebooks must run top-to-bottom.** Restart kernel and run all cells. A notebook that only works with manual cell ordering is broken.
- **State the verification method first.** Before writing a pipeline step, say how you'll validate it (test / assertion / output shape check).
- **Notebook outputs are NOT tests.** Utility functions in `.py` files need real pytest tests.

### Planning
- **Use plan mode for new pipelines or model changes.** Data loading + feature engineering + training + evaluation = plan first.
- **No guessing.** Don't fabricate column names, feature shapes, or model hyperparameters. Inspect the data first.
- **Document assumptions.** State what you assume about the data (distributions, missing values, cardinality) before writing transforms.

### Code Quality
- **Type hints on all functions in `.py` files.** Notebooks are exempt, but scripts and modules must be typed.
- **No placeholder code.** Every function must do something real. No `pass` stubs.
- **Prefer editing over creating.** Check if a utility or pipeline step already exists before creating a new one.
- **DRY between notebooks and scripts.** Shared logic goes in `src/` modules, imported into notebooks. Don't copy-paste between notebooks.

### Data Handling
- **Never commit raw data over 10MB.** Use `.gitignore` for `data/raw/` and large files. Document download instructions in README.
- **Pandas: No `iterrows()`.** Use vectorized operations, `.apply()` with vectorized functions, or numpy operations.
- **Validate data at boundaries.** Assert expected shapes, dtypes, and value ranges after loading and after each transform step.
- **Track data lineage.** Comment where each dataset comes from and what transforms produced it.

### Reproducibility
- **Set random seeds everywhere.** `np.random.seed()`, `random.seed()`, and model-specific seeds (e.g., `random_state` in sklearn).
- **Pin all dependency versions.** `requirements.txt` with exact versions (`pandas==2.1.4`, not `pandas>=2`).
- **Use virtual environments.** venv or conda. Document the setup command in README.
- **Log experiment parameters.** When training a model, log hyperparameters, dataset version, and metrics together.

### Models
- **Save models to `models/` with version in filename.** e.g., `models/classifier_v3_2026-03-08.pkl`. Never overwrite — create new versions.
- **Evaluate on held-out data.** Train/test split or cross-validation. Never report training metrics as final results.
- **Document model performance.** Log metrics (accuracy, F1, RMSE, etc.) alongside the saved model.

### Visualization
- **Always label axes and add titles.** Every plot must have xlabel, ylabel, and a descriptive title.
- **Use consistent styling.** Set a seaborn/matplotlib style at the top of each notebook. Save important plots to `reports/figures/`.

### Project Structure
- Notebooks in `notebooks/` — numbered for ordering (e.g., `01_exploration.ipynb`, `02_feature_engineering.ipynb`).
- Reusable code in `src/` — data loading, feature engineering, model utilities.
- Raw data in `data/raw/`, processed data in `data/processed/`.
- Trained models in `models/`. Reports and figures in `reports/`.

### Communication
- **One step at a time.** Don't dump checklists. Give the next action, wait, then continue.
- **Lead with the problem.** When asked "what do you think?" — say what's wrong first.

## Environment
- Platform: [macOS / Linux / Windows Git Bash]
- Python: 3.11+, use `python` (or `python3` on macOS/Linux)
- Package manager: pip with `requirements.txt` (or conda with `environment.yml`)
- Never auto-commit.
- Jupyter: `jupyter lab` or `jupyter notebook` for interactive work.
- Large data paths in environment variables or config file. Never hardcode absolute paths.

## Skill Triggers
- `debugging` -> shape mismatches, NaN propagation, convergence failures, memory errors
- `code-review` -> before merging any feature branch
- `architecture-decision` -> choosing between models, feature strategies, data architectures
- `research` -> comparing ML approaches, evaluating libraries, reviewing papers

## Key Files
| File | Purpose |
|------|---------|
| `memory/MEMORY.md` | Persistent state — decisions, status, patterns |
| `notebooks/` | Jupyter notebooks — exploration, training, evaluation |
| `src/data.py` | Data loading and preprocessing utilities |
| `src/features.py` | Feature engineering functions |
| `src/model.py` | Model training, evaluation, and prediction |
| `models/` | Saved trained models (versioned) |
| `data/raw/` | Raw input data (gitignored if large) |
| `data/processed/` | Cleaned and transformed data |
| `reports/figures/` | Saved plots and visualizations |
| `requirements.txt` | Pinned Python dependencies |

## MCP Usage Protocol
- Prefer Read/Write/Glob/Grep tools over shell commands for file operations.
- Check tool availability before assuming an MCP server is connected.
- Never loop API calls without explicit approval.

## Memory Management
- Read `memory/MEMORY.md` at session start.
- Update memory when a model decision is made, a dataset changes, or experiment results are confirmed.
- Delete stale entries. Outdated memory is worse than no memory.
