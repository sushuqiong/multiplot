const fs = require("fs");
const {
  Document, Packer, Paragraph, TextRun, Table, TableRow, TableCell,
  Header, Footer, AlignmentType, HeadingLevel, BorderStyle, WidthType,
  ShadingType, PageNumber, PageBreak, LevelFormat, TableOfContents
} = require("docx");

// --- Helper functions ---
const heading1 = (text) => new Paragraph({
  heading: HeadingLevel.HEADING_1, spacing: { before: 360, after: 200 },
  children: [new TextRun({ text, bold: true, font: "Arial", size: 32 })]
});

const heading2 = (text) => new Paragraph({
  heading: HeadingLevel.HEADING_2, spacing: { before: 240, after: 160 },
  children: [new TextRun({ text, bold: true, font: "Arial", size: 28 })]
});

const heading3 = (text) => new Paragraph({
  heading: HeadingLevel.HEADING_3, spacing: { before: 200, after: 120 },
  children: [new TextRun({ text, bold: true, font: "Arial", size: 26 })]
});

const para = (text, opts = {}) => new Paragraph({
  spacing: { after: 120, line: 276 },
  children: [new TextRun({ text, font: "Arial", size: 24, ...opts })]
});

const boldPara = (label, text) => new Paragraph({
  spacing: { after: 120, line: 276 },
  children: [
    new TextRun({ text: label + " ", bold: true, font: "Arial", size: 24 }),
    new TextRun({ text, font: "Arial", size: 24 })
  ]
});

const cell = (text, opts = {}) => new TableCell({
  borders: { top: { style: BorderStyle.SINGLE, size: 1, color: "999999" },
              bottom: { style: BorderStyle.SINGLE, size: 1, color: "999999" },
              left: { style: BorderStyle.SINGLE, size: 1, color: "999999" },
              right: { style: BorderStyle.SINGLE, size: 1, color: "999999" }},
  width: { size: opts.width || 2000, type: WidthType.DXA },
  shading: opts.shading ? { fill: opts.shading, type: ShadingType.CLEAR } : undefined,
  margins: { top: 60, bottom: 60, left: 100, right: 100 },
  children: [new Paragraph({
    spacing: { after: 0 },
    children: [new TextRun({ text, font: "Arial", size: opts.size || 20, bold: opts.bold || false })]
  })]
});

// --- References ---
const refs = [
  "Weissgerber TL, Milic NM, Winham SJ, Garovic VD. Beyond bar and line graphs: time for a new data presentation paradigm. PLoS Biol. 2015;13(4):e1002128.",
  "Rougier NP, Droettboom M, Bourne PE. Ten simple rules for better figures. PLoS Comput Biol. 2014;10(9):e1003833.",
  "Crameri F, Shephard GE, Heron PJ. The misuse of colour in science communication. Nat Commun. 2020;11(1):5444.",
  "Stauffer R, Mayr GJ, Dabernig M, Zeileis A. Somewhere over the rainbow: How to make effective use of colors in meteorological visualizations. Bull Am Meteorol Soc. 2015;96(2):203-216.",
  "Weissgerber TL, Winham SJ, Heinzen EP, et al. Reveal, don't conceal: transforming data visualization to improve transparency. Circulation. 2019;140(18):1506-1518.",
  "Peng RD. Reproducible research in computational science. Science. 2011;334(6060):1226-1227.",
  "Dawson C. ggprism: A 'ggplot2' Extension Inspired by 'GraphPad Prism'. R package version 1.0.7. 2025. doi:10.32614/CRAN.package.ggprism.",
  "Alfons A. r2spss: Format R Output to Look Like SPSS. R package version 0.3.2. 2022. https://CRAN.R-project.org/package=r2spss.",
  "Arnold JB. ggthemes: Extra Themes, Scales and Geoms for 'ggplot2'. R package version 5.1.0. 2024. https://CRAN.R-project.org/package=ggthemes.",
  "Wilke CO. cowplot: Streamlined Plot Theme and Plot Annotations for 'ggplot2'. R package version 1.2.0. 2025. https://wilkelab.org/cowplot/.",
  "Schloss KB, Lessard L, Walmsley CS, Foley K. Color inference in visual communication: the meaning of colors in recycling. Cogn Res Princ Implic. 2018;3(1):5.",
  "Birch J. Worldwide prevalence of red-green color deficiency. J Opt Soc Am A. 2012;29(3):313-320.",
  "Zeileis A, Fisher JC, Hornik K, et al. colorspace: A toolbox for manipulating and assessing colors and palettes. J Stat Softw. 2020;96(1):1-49.",
  "Pedersen TL, Nicolae B, Francois R. farver: High performance colour space manipulation. R package version 2.1.2. 2024. https://CRAN.R-project.org/package=farver."
];

// --- Build document ---
const children = [];

// ===== TITLE PAGE =====
children.push(new Paragraph({ spacing: { before: 3600 }, children: [] }));
children.push(new Paragraph({
  alignment: AlignmentType.CENTER, spacing: { after: 400 },
  children: [new TextRun({ text: "multiplot: A Unified Framework and R Implementation for Reproducing Biomedical Statistical Plot Styles Across Ten Major Graphing Software Packages", bold: true, font: "Arial", size: 36 })]
}));
children.push(new Paragraph({
  alignment: AlignmentType.CENTER, spacing: { after: 200 },
  children: [new TextRun({ text: "Feng Qiao", font: "Arial", size: 28 })]
}));
children.push(new Paragraph({
  alignment: AlignmentType.CENTER, spacing: { after: 100 },
  children: [new TextRun({ text: "July 2026", font: "Arial", size: 24 })]
}));
children.push(new Paragraph({
  alignment: AlignmentType.CENTER, spacing: { after: 100 },
  children: [new TextRun({ text: "R package: multiplot v0.1.0", font: "Arial", size: 22, italics: true })]
}));
children.push(new Paragraph({
  alignment: AlignmentType.CENTER, spacing: { after: 100 },
  children: [new TextRun({ text: "License: MIT", font: "Arial", size: 22 })]
}));
children.push(new Paragraph({ children: [new PageBreak()] }));

// ===== ABSTRACT =====
children.push(heading1("Abstract"));
children.push(boldPara("Background:", "Biomedical researchers routinely switch between statistical graphing software (GraphPad Prism, SPSS, OriginPro, Stata, MATLAB, etc.), each with a distinctive default visual style. When publishing, the absence of a unified method to replicate these styles programmatically creates friction: plots generated in R may be rejected by reviewers accustomed to specific software aesthetics, and manual re-styling per target journal is inefficient."));
children.push(boldPara("Results:", "We present (1) a formal Plot Style Ontology that decomposes any statistical graphing software's default output into a 5-tuple of {Theme, Palette, Geom, Annotation, Convention} dimensions; (2) a systematic compliance assessment of ten software default palettes across colour vision deficiency (CVD) safety, grayscale print fidelity, and CMYK gamut compatibility; and (3) multiplot, an open-source R package implementing the ontology as a ggplot2 extension. A single ggchoice(\"prism\") call applies the complete visual style of the target software. The package exports 17 functions, requires only ggplot2 (≥3.4.0), and passes R CMD check with zero errors or warnings."));
children.push(boldPara("Conclusions:", "multiplot fills a gap between general-purpose ggplot2 theme packages and single-software emulators, providing the first unified framework for cross-software plot style reproduction with built-in publication compliance guidance. The formal ontology and compliance benchmark are reusable beyond the R ecosystem."));
children.push(para("Keywords: data visualization, ggplot2, R package, statistical graphics, GraphPad Prism, SPSS, colour vision deficiency, reproducible research", { italics: true }));
children.push(new Paragraph({ children: [new PageBreak()] }));

// ===== INTRODUCTION =====
children.push(heading1("1. Introduction"));
children.push(para("Biomedical and life-science researchers produce statistical graphs using a heterogeneous mix of software: GraphPad Prism for dose-response curves, SPSS for survey-weighted bar charts, OriginPro for multi-panel scientific figures, Stata for econometric-style regressions, MATLAB for engineering visualizations, and MedCalc for diagnostic ROC analysis [1-4]. Each software ships with a distinctive default visual style—a specific combination of background colour, grid line presence, font family, axis formatting, and colour palette—that becomes deeply familiar to its user community."));
children.push(para("This fragmentation creates two problems. First, reviewer expectation: manuscript reviewers accustomed to one software's visual conventions may perceive plots generated with a different tool as \"unfamiliar\" or \"unpolished,\" even when statistically identical [5]. Second, reproducibility friction: a computationally reproducible analysis pipeline (e.g., in R) produces output that may not match the visual style expected by a target journal or co-author using a different primary software [6]."));
children.push(para("Existing R packages address parts of this problem. ggprism [7] provides GraphPad Prism-inspired themes and palettes for ggplot2 but covers only one software. r2spss [8] replicates SPSS output formatting, including legacy and modern SPSS graph styles, but is similarly single-software. ggthemes [9] offers themes inspired by publications (The Economist, Wall Street Journal) and software (Stata, Excel) but prioritises aesthetic variety over fidelity to software defaults. cowplot [10] provides a clean publication-ready default theme but makes no attempt to emulate specific software. None of these packages provide (a) multi-software coverage, (b) a formal framework for reasoning about plot style differences, or (c) systematic guidance on which default styles meet publication accessibility standards."));
children.push(para("Here we introduce multiplot, an R package that addresses all three gaps. Its contributions are:"));
children.push(para("1. A Plot Style Ontology that formalises any graphing software's default visual output as a 5-tuple of {Theme, Palette, Geom, Annotation, Convention};"));
children.push(para("2. A single-function entry point, ggchoice(\"style\"), that applies the complete style (theme + colour scale + fill scale) of ten major statistical graphing software packages;"));
children.push(para("3. A systematic compliance assessment of each software's default palette against CVD safety, grayscale print fidelity, and CMYK gamut compatibility, providing actionable guidance for journal submission."));
children.push(new Paragraph({ children: [new PageBreak()] }));

// ===== METHODS =====
children.push(heading1("2. Methods"));

children.push(heading2("2.1 Plot Style Ontology"));
children.push(para("We formalise a plotting software's default visual style as a 5-tuple:"));
children.push(new Paragraph({
  alignment: AlignmentType.CENTER, spacing: { before: 120, after: 120 },
  children: [new TextRun({ text: "Style = {Theme, Palette, Geom, Annotation, Convention}", font: "Arial", size: 24, italics: true })]
}));
children.push(para("where each component is defined as follows:"));

// Ontology table
const ontoHeader = ["Component", "Definition", "Dimensions"];
const ontoRows = [
  ["Theme (T)", "Canvas-level visual parameters independent of data", "Background fill, grid major/minor, panel border, axis line, tick direction, font family, title face/size, legend position/border, facet strip"],
  ["Palette (P)", "Default colour-mapping strategy", "Palette type (qualitative/sequential/diverging), colour count, hex values, CVD safety profile"],
  ["Geom (G)", "Default geometric object rendering", "Bar fill colour, line colour/width, point shape/size, error bar style"],
  ["Annotation (A)", "Default statistical annotation conventions", "Significance notation format (P values vs. stars), reference line style, AUC annotation placement"],
  ["Convention (C)", "Software-specific layout conventions", "Default aspect ratio, y-axis range start, axis label orientation, multi-panel strategy"]
];
children.push(new Table({
  width: { size: 9360, type: WidthType.DXA },
  columnWidths: [2000, 3000, 4360],
  rows: [
    new TableRow({ children: ontoHeader.map((h, i) => cell(h, { bold: true, shading: "D5E8F0", width: [2000, 3000, 4360][i] })) }),
    ...ontoRows.map(row => new TableRow({ children: row.map((c, i) => cell(c, { width: [2000, 3000, 4360][i] })) }))
  ]
}));
children.push(para(""));
children.push(para("This decomposition is deliberately minimalist: each dimension is directly observable from the software's default output and independently implementable in ggplot2 without modifying its internal rendering pipeline."));

children.push(heading2("2.2 Software Selection and Style Extraction"));
children.push(para("We selected ten software packages covering the most commonly used statistical graphing tools in biomedical research [1,2]:"));
children.push(para("1. GraphPad Prism (v8+); 2. IBM SPSS Statistics (v12–24 classic default); 3. OriginPro (classic default; OriginLab); 4. Stata (s2color scheme, factory default pre-v18); 5. Academic/AMS (generic journal submission style); 6. SigmaPlot (v8.0+; Systat Software); 7. JMP (v13+; SAS Institute); 8. MATLAB (R2014b+ default; MathWorks); 9. Minitab (v17+; Minitab LLC); 10. MedCalc (v20+; MedCalc Software)."));
children.push(para("For each software, we extracted the default visual parameters from: (i) official software documentation and user guides; (ii) default scheme/theme definition files (e.g., Stata's scheme-s2color.scheme, MATLAB's ColorOrder defaults); (iii) direct software output inspection verified against documentation for Prism, SPSS, OriginPro, and MATLAB; and (iv) published descriptions in the methodology literature [3,4,11]. The full ontology mapping is provided in Table 1 (Supplementary Materials)."));

children.push(heading2("2.3 Implementation in R"));
children.push(para("The multiplot R package implements the ontology on top of ggplot2 (≥3.4.0). The architecture follows a layered design:"));
children.push(para("10 internal theme_xxx() functions—each inherits from theme_bw() or theme_classic() and overrides grid, border, font, legend, and strip parameters to match the target software's defaults."));
children.push(para("20 internal discrete scale_color/fill_xxx() functions—each defines a qualitative palette of 10 hex colours extracted from the software's default colour order."));
children.push(para("14 exported continuous scale_color/fill_xxx_c() functions—each wraps ggplot2::scale_color_gradientn() with a software-specific continuous gradient (e.g., MATLAB's parula, Origin's BlueGreenYellow)."));
children.push(para("1 exported ggchoice() function—the main entry point. Calling ggchoice(\"prism\") returns a list of theme_prism() + scale_color_prism() + scale_fill_prism(). Scales are applied additively: user-supplied scale_*() calls added after ggchoice() take priority (ggplot2's \"later-wins\" semantics)."));
children.push(para("1 exported geom_errorbar_prism()—a wrapper around ggplot2::geom_errorbar() with Prism-style cap width and line weight defaults."));
children.push(para("1 exported stat_compare_means_prism()—wraps ggpubr::stat_compare_means() with Prism-style p-value formatting (P < 0.0001 cutoff, significance stars)."));
children.push(para("All themes and scales are internal (not exported), keeping the user-facing API to 17 exported functions. The package has zero compiled code and imports only ggplot2."));

children.push(heading2("2.4 Compliance Assessment Methodology"));
children.push(para("We assessed each software's default discrete palette across three dimensions:"));
children.push(boldPara("CVD Safety.", "Each palette was simulated under three colour vision deficiency types using the methodology of [12]: deuteranopia (M-cone loss, ~6% male prevalence), protanopia (L-cone loss, ~2%), and tritanopia (S-cone loss, <0.01%). A palette was scored 5 if all colours remain distinguishable across all three types; 3 if ≥3 colours remain distinguishable; 1 if red-green confusion renders ≥2 pairs indistinguishable."));
children.push(boldPara("Grayscale Print Fidelity.", "CIELAB L* (lightness) values were computed for each hex colour (D65 illuminant, 2° observer). A palette was scored 5 if ≥5 distinct L* levels span the 0–100 range; 3 if 3–4 levels; 1 if ≤2 levels."));
children.push(boldPara("CMYK Gamut Compatibility.", "ΔE (CIEDE2000) between sRGB and ISO Coated v2 (FOGRA39) CMYK profile was computed for each colour. A palette was scored 5 if all colours are within ΔE < 3; 3 if 1–2 colours exceed ΔE > 5; 1 if ≥3 colours are substantially out-of-gamut (ΔE > 8)."));
children.push(para("All colour computations were performed using the colorspace [13] and farver [14] R packages."));

children.push(heading2("2.5 Comparison with Existing Packages"));
const cmpHeader = ["Feature", "multiplot", "ggprism", "r2spss", "ggthemes", "cowplot"];
const cmpRows = [
  ["Multi-software coverage", "10", "1 (Prism)", "1 (SPSS)", "~8 themes*", "1 (generic)"],
  ["Formal style ontology", "Yes", "No", "No", "No", "No"],
  ["Compliance assessment", "Yes", "No", "No", "No", "No"],
  ["Single-function style", "Yes", "Partial**", "Partial**", "Partial**", "N/A"],
  ["Continuous colour scales", "Yes (14)", "No", "No", "Limited", "No"],
  ["Prism-specific geoms", "Yes", "Yes", "N/A", "No", "No"],
  ["Vignette comparison", "Yes", "No", "No", "No", "No"]
];
children.push(new Table({
  width: { size: 9360, type: WidthType.DXA },
  columnWidths: [2000, 1400, 1200, 1200, 1400, 1200],
  rows: [
    new TableRow({ children: cmpHeader.map((h, i) => cell(h, { bold: true, shading: "D5E8F0", width: [2000, 1400, 1200, 1200, 1400, 1200][i] })) }),
    ...cmpRows.map(row => new TableRow({ children: row.map((c, i) => cell(c, { width: [2000, 1400, 1200, 1200, 1400, 1200][i], bold: row[0] === "Multi-software coverage" || row[0] === "Formal style ontology" || row[0] === "Compliance assessment" ? (i === 1) : false })) }))
  ]
}));
children.push(para("* Includes Stata, Excel, Economist, WSJ, FiveThirtyEight, etc. — not all scientific graphing software.", { size: 20 }));
children.push(para("** Requires separate theme_xxx() + scale_xxx() calls.", { size: 20 }));

children.push(new Paragraph({ children: [new PageBreak()] }));

// ===== RESULTS =====
children.push(heading1("3. Results"));

children.push(heading2("3.1 Ontology Mapping"));
children.push(para("The complete ontology mapping is presented in Table 1 (Supplementary Materials). Key findings from the cross-software comparison:"));
children.push(para("• Grid usage: 5/10 software default to grid OFF; 3/10 use light grids; 2/10 use distinctive grid patterns (Minitab white-on-grey, Stata thin bluish)."));
children.push(para("• Frame: 6/10 use a full box border; 4/10 use axes-only (Academic, JMP, MATLAB, Stata)."));
children.push(para("• Font: 10/10 default to sans-serif (Arial/Helvetica variants). No major statistical graphing software defaults to a serif font for chart elements."));
children.push(para("• Legend: 5/10 place right; 2/10 place bottom; MedCalc places inside the plot area."));
children.push(para("• Palette strategy: 5/10 use qualitative colour cycles; 1/10 uses grayscale; 1/10 uses B&W-then-grayscale."));
children.push(para("The formalisation reveals that no two software packages share an identical 5-tuple, confirming that each software's \"look\" is a genuinely distinctive combination rather than minor variation around a common template."));

children.push(heading2("3.2 Compliance Assessment"));
children.push(para("The full compliance scores are presented in Table 2 (Supplementary Materials). Key findings:"));

const scoreHeader = ["Software", "CVD", "Grayscale", "CMYK", "Overall"];
const scoreRows = [
  ["Academic", "5.0", "5.0", "5.0", "5.0"],
  ["SigmaPlot", "5.0", "5.0", "5.0", "5.0"],
  ["MATLAB (R2014b+)", "3.0", "4.0", "4.0", "3.7"],
  ["Prism", "3.0", "3.0", "4.0", "3.3"],
  ["SPSS, Stata, JMP, Minitab, MedCalc", "2.0", "3.0", "4.0", "3.0"],
  ["OriginPro", "1.0", "2.0", "2.0", "1.7"]
];
children.push(new Table({
  width: { size: 7000, type: WidthType.DXA },
  columnWidths: [2600, 1100, 1100, 1100, 1100],
  rows: [
    new TableRow({ children: scoreHeader.map((h, i) => cell(h, { bold: true, shading: "D5E8F0", width: [2600, 1100, 1100, 1100, 1100][i] })) }),
    ...scoreRows.map(row => new TableRow({ children: row.map((c, i) => cell(c, { width: [2600, 1100, 1100, 1100, 1100][i], bold: (i === 4) })) }))
  ]
}));
children.push(para(""));
children.push(para("The most common failure mode is red-green colour pair confusability (deuteranopia/protanopia), affecting 8/10 software default palettes. Only grayscale-based defaults (Academic, SigmaPlot) are fully CVD-safe. Notably, MATLAB R2014b+ deliberately improved CVD accessibility (3.0 vs. the older jet-based default which would score 1.0), demonstrating that software vendors are beginning to address this issue."));

children.push(heading2("3.3 Use Case: Cross-Style Comparison"));
children.push(para("As a demonstration, the same boxplot of highway fuel economy by vehicle class (mpg dataset) was rendered in all 10 styles. The visual differences are substantial despite identical underlying data:"));
children.push(para("• Prism and SPSS produce the most \"traditional biomedical\" appearance (clean white backgrounds, no grid, box borders)."));
children.push(para("• Stata and Minitab have the most distinctive backgrounds (light bluish tint and grey, respectively), making them immediately recognisable to users familiar with those packages."));
children.push(para("• MATLAB and JMP produce the most minimal, modern appearance (no outer frame, sparse annotation)."));
children.push(para("• Academic and SigmaPlot produce the most conservative output, suitable for journals with strict figure guidelines."));
children.push(para("This demonstrates the ontology's practical value: a researcher can produce a Prism-style plot for a pharmacology co-author, an SPSS-style plot for a psychology reviewer, and an Academic-style plot for final journal submission—all from the same R script, without manually adjusting individual theme parameters."));
children.push(new Paragraph({ children: [new PageBreak()] }));

// ===== DISCUSSION =====
children.push(heading1("4. Discussion"));

children.push(heading2("4.1 Contribution"));
children.push(para("multiplot is, to our knowledge, the first R package to provide both multi-software coverage and a formal ontology for reasoning about statistical plot styles. Its three contributions—ontology, implementation, and compliance benchmark—are mutually reinforcing: the ontology provides the vocabulary for describing differences; the implementation demonstrates that these differences are mechanically reproducible; and the compliance benchmark reveals which defaults are fit for purpose in accessible, print-ready publication."));

children.push(heading2("4.2 Design Rationale"));
children.push(para("We chose to make theme and scale functions internal (not exported) with ggchoice() as the single user-facing entry point. This design reflects a philosophical position: the unit of \"style\" is the combination of theme + palette, not either in isolation. Exporting theme_prism() without its corresponding palette would invite users to produce Prism-themed plots with ggplot2's default hue wheel—defeating the purpose of style reproduction."));
children.push(para("The additive-scale strategy (user scales override multiplot scales) preserves ggplot2's composability while providing sensible defaults. This differs from ggprism, which exports separate theme_prism() and scale_fill_prism() functions requiring explicit coordination by the user."));

children.push(heading2("4.3 Limitations"));
children.push(para("1. Fidelity: While parameters were extracted from official documentation, scheme files, and cross-referenced with reference packages (ggprism, r2spss), a formal perceptual fidelity study with side-by-side comparison has not yet been completed. Small differences in anti-aliasing, font metrics, and rendering engine behaviour may exist."));
children.push(para("2. Software versioning: Software defaults evolve (e.g., SPSS 25+ modern charts, Stata 18's stcolor replacing s2color). We target the most widely recognisable defaults."));
children.push(para("3. Continuous palettes: Our continuous colour scales use fixed keypoint interpolation rather than the exact algorithmic colormaps of the original software (e.g., MATLAB's parula uses a piecewise Bézier curve; we approximate with 9 keypoints)."));
children.push(para("4. 3D and interactive plots: multiplot covers only 2D static ggplot2 output. Interactive features (JMP's hover tooltips, Prism's linked analyses) are out of scope."));

children.push(heading2("4.4 Future Work"));
children.push(para("• Formal perceptual fidelity study with human raters (N ≥ 20) comparing multiplot output to real software screenshots;"));
children.push(para("• Support for additional software (SAS, RStudio default, Python matplotlib/seaborn);"));
children.push(para("• Shiny gadget for interactive style preview and on-the-fly switching;"));
children.push(para("• Journal-specific templates (Nature, Cell, Science, The Lancet) built on the Academic base;"));
children.push(para("• Extension to Python (matplotlib-based ggchoice() equivalent)."));
children.push(new Paragraph({ children: [new PageBreak()] }));

// ===== AVAILABILITY =====
children.push(heading1("5. Availability"));
children.push(para("Package: multiplot v0.1.0"));
children.push(para("Language: R (≥4.0)"));
children.push(para("License: MIT"));
children.push(para("Dependencies: ggplot2 (≥3.4.0); ggpubr (optional, for stat_compare_means_prism())"));
children.push(para("Source code: https://github.com/sushuqiong/multiplot"));
children.push(para("Documentation: Vignette included (vignette(\"multiplot\"))"));
children.push(para("Supplementary Materials: Table 1 (Plot Style Ontology), Table 2 (Compliance Assessment) included in inst/paper/"));
children.push(new Paragraph({ children: [new PageBreak()] }));

// ===== REFERENCES =====
children.push(heading1("References"));
refs.forEach((r, i) => {
  children.push(new Paragraph({
    spacing: { after: 100 },
    children: [
      new TextRun({ text: `[${i + 1}] `, font: "Arial", size: 20 }),
      new TextRun({ text: r, font: "Arial", size: 20 })
    ]
  }));
});
children.push(new Paragraph({ children: [new PageBreak()] }));

// ===== SUPPLEMENTARY =====
children.push(heading1("Supplementary Materials"));
children.push(heading2("Table 1 — Plot Style Ontology"));
children.push(para("The complete 10-software × 15-attribute mapping across all five ontology dimensions (Theme, Palette, Geom, Annotation, Convention) is provided in the file inst/paper/table1_style_ontology.md within the multiplot package repository."));
children.push(heading2("Table 2 — Compliance Assessment"));
children.push(para("The full CVD safety, grayscale fidelity, and CMYK compatibility evaluation with CIELAB L* values and per-colour gamut analysis is provided in the file inst/paper/table2_compliance_assessment.md within the multiplot package repository."));

// ===== Assemble =====
const doc = new Document({
  styles: {
    default: { document: { run: { font: "Arial", size: 24 } } },
    paragraphStyles: [
      { id: "Heading1", name: "Heading 1", basedOn: "Normal", next: "Normal", quickFormat: true,
        run: { size: 32, bold: true, font: "Arial" },
        paragraph: { spacing: { before: 360, after: 200 }, outlineLevel: 0 } },
      { id: "Heading2", name: "Heading 2", basedOn: "Normal", next: "Normal", quickFormat: true,
        run: { size: 28, bold: true, font: "Arial" },
        paragraph: { spacing: { before: 240, after: 160 }, outlineLevel: 1 } },
      { id: "Heading3", name: "Heading 3", basedOn: "Normal", next: "Normal", quickFormat: true,
        run: { size: 26, bold: true, font: "Arial" },
        paragraph: { spacing: { before: 200, after: 120 }, outlineLevel: 2 } }
    ]
  },
  sections: [{
    properties: {
      page: {
        size: { width: 12240, height: 15840 },
        margin: { top: 1440, right: 1440, bottom: 1440, left: 1440 }
      }
    },
    headers: {
      default: new Header({
        children: [new Paragraph({
          alignment: AlignmentType.RIGHT,
          children: [new TextRun({ text: "multiplot Manuscript", font: "Arial", size: 18, italics: true, color: "888888" })]
        })]
      })
    },
    footers: {
      default: new Footer({
        children: [new Paragraph({
          alignment: AlignmentType.CENTER,
          children: [
            new TextRun({ text: "Page ", font: "Arial", size: 18, color: "888888" }),
            new TextRun({ children: [PageNumber.CURRENT], font: "Arial", size: 18, color: "888888" })
          ]
        })]
      })
    },
    children
  }]
});

// Write
const outPath = "C:/Users/fengq/Desktop/multiplot_manuscript.docx";
Packer.toBuffer(doc).then(buffer => {
  fs.writeFileSync(outPath, buffer);
  console.log("Document written to " + outPath);
  console.log("Size: " + (buffer.length / 1024).toFixed(1) + " KB");
});
