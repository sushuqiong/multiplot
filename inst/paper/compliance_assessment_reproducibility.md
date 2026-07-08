# Compliance Assessment Reproducibility Log

Generated: 2026-07-08 13:27:52 CST
R: R version 4.4.1 (2024-06-14 ucrt)
colorspace: 2.1.1
farver: 2.1.2

Scoring rules:
- CVD: minimum pairwise CIE76 distance after deuteranopia, protanopia, and tritanopia simulation; grayscale palettes are treated as CVD-safe; pure red/green pairs are treated as critical; otherwise >=20=5, >=15=4, >=10=3, >=4=2, <4=1.
- Grayscale: number of CIELAB L* groups separated by at least 8 units among the first five colours, with total L* range checks.
- CMYK: reproducible approximate print-risk score based on RGB saturation and pure-channel risk, used as a transparent proxy when no ICC profile is bundled.
- Overall: arithmetic mean of CVD, grayscale, and CMYK scores, rounded to one decimal place.

style | n_colours_scored | min_cvd_delta_e | cvd_score | grayscale_score | cmyk_score | overall
--- | --- | --- | --- | --- | --- | ---
Academic | 5 | 10.1 | 5 | 5 | 5 | 5.0
SigmaPlot | 5 |  9.4 | 5 | 5 | 5 | 5.0
MATLAB R2014b+ | 5 | 10.5 | 3 | 4 | 5 | 4.0
Minitab | 5 | 14.4 | 3 | 3 | 5 | 3.7
MedCalc | 5 |  9.5 | 2 | 3 | 5 | 3.3
Prism | 5 | 14.8 | 3 | 3 | 4 | 3.3
SPSS | 5 |  7.1 | 2 | 3 | 5 | 3.3
Stata s2color | 5 |  6.9 | 2 | 4 | 4 | 3.3
JMP | 5 |  4.8 | 2 | 3 | 4 | 3.0
OriginPro | 5 | 10.2 | 1 | 4 | 2 | 2.3
