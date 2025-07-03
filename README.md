# Traffic Accident Severity Prediction Using Bayesian Machine Learning

## Project Overview
Developed a sophisticated machine learning system to predict traffic accident severity using Bayesian ordinal regression on a massive dataset of 7.7 million U.S. traffic accidents. 
This project addresses critical public safety concerns by identifying key factors contributing to accident severity and providing probabilistic predictions for risk assessment 
and prevention strategies.

## Methods & Strategy
Statistical Methods:

- Implemented Bayesian Ordinal Regression with MCMC (Metropolis-Hastings) sampling for probabilistic modeling
- Applied regularization techniques (Ridge and Lasso regression) for feature selection and overfitting prevention
- Conducted cross-validated feature selection to identify optimal predictors from high-dimensional data
- Developed comparative analysis between ordinal and nominal classification approaches

Bayesian Statistical Analysis:

- Designed custom prior distributions (Normal and Cauchy priors) for model parameters
- Implemented MCMC convergence diagnostics using R-hat statistics and Effective Sample Size (ESS)
- Generated posterior predictive distributions with credible intervals for uncertainty quantification
- Applied Bayesian model selection and validation techniques

Big Data Processing & Feature Engineering:

- Processed and cleaned 7.7 million traffic accident records with comprehensive data preprocessing pipeline
- Handled missing data with systematic imputation strategies (removed columns >50% missing)
- Created engineered features including temporal variables (time-of-day categories) and interaction terms
- Applied z-score normalization and categorical encoding for model optimization

Advanced Feature Selection:

- Implemented Lasso regression with cross-validation for automated feature selection (λ = 0.0045)
- Analyzed multicollinearity using correlation matrices and variance inflation factors
- Tested pairwise interaction terms to capture complex predictor relationships
- Selected optimal feature set: 4 binary variables, 4 continuous variables, and 4 interaction terms

## Bayesian Framework 
Bayesian Ordinal Regression Framework:
log(P(Y ≤ c)/P(Y > c)) = αc - Xβ

- Modeled accident severity as ordinal outcome (1: minor → 4: fatal)
- Used weakly informative priors: β ~ N(0,1), αc ~ Cauchy(0,2)
- Implemented custom likelihood functions for ordinal outcomes

MCMC Implementation:

- Achieved successful convergence with minimum ESS of 2,800 across all chains
- R-hat values close to 1.0 indicating proper chain mixing
- Generated stable posterior estimates through trace plot analysis

## Key Findings
Predictive Performance:

- Achieved Mean Absolute Error (MAE) of 0.91 for severity prediction
- Misclassification rate of 63.5% with predictions typically within one severity category
- Demonstrated reasonable alignment between predicted and observed severity distributions

Feature Importance Discovery:

- Road infrastructure factors emerged as most predictive (Traffic Signals, Junctions, Crossings)
- Weather-related variables showed lower predictive power than infrastructure features
- Interaction effects between binary road features significantly improved classification accuracy
- Temporal patterns revealed higher severity accidents during nighttime hours

Statistical Significance:

- Generated 95% credible intervals for all model parameters
- Identified robust category thresholds (αi) with tight credible intervals
- Quantified uncertainty in parameter estimates through posterior distributions
