const fs = require("fs");
const {
  Document, Packer, Paragraph, TextRun, Table, TableRow, TableCell,
  Header, Footer, AlignmentType, HeadingLevel, BorderStyle, WidthType,
  ShadingType, PageNumber, PageBreak
} = require("docx");

// ============================================================
// Three-line table helpers (三线表)
// ============================================================
const thickBorder = { style: BorderStyle.SINGLE, size: 12, color: "000000" };
const thinBorder  = { style: BorderStyle.SINGLE, size: 6, color: "000000" };
const noBorder    = { style: BorderStyle.SINGLE, size: 1, color: "FFFFFF" };

const topBorders = { top: thickBorder, bottom: noBorder, left: noBorder, right: noBorder };
const headBorders = { top: noBorder, bottom: thinBorder, left: noBorder, right: noBorder };
const midBorders = { top: noBorder, bottom: noBorder, left: noBorder, right: noBorder };
const bottomBorders = { top: noBorder, bottom: thickBorder, left: noBorder, right: noBorder };

const thCell = (text, width) => new TableCell({
  borders: headBorders,
  width: { size: width, type: WidthType.DXA },
  margins: { top: 60, bottom: 80, left: 100, right: 100 },
  children: [new Paragraph({ spacing: { after: 0 }, children: [new TextRun({
    text, font: "Arial", size: 20, bold: true
  })], alignment: AlignmentType.CENTER })]
});

const tdCell = (text, width, opts = {}) => new TableCell({
  borders: midBorders,
  width: { size: width, type: WidthType.DXA },
  margins: { top: 40, bottom: 40, left: 100, right: 100 },
  children: [new Paragraph({ spacing: { after: 0 }, children: [new TextRun({
    text, font: "Arial", size: 18, ...opts
  })], alignment: opts.center ? AlignmentType.CENTER : AlignmentType.LEFT })]
});

const bottomRow = (texts, widths) => new TableRow({
  children: texts.map((t, i) => new TableCell({
    borders: bottomBorders,
    width: { size: widths[i], type: WidthType.DXA },
    margins: { top: 40, bottom: 60, left: 100, right: 100 },
    children: [new Paragraph({ spacing: { after: 0 }, children: [new TextRun({
      text: t, font: "Arial", size: 18
    })] })]
  }))
});

// ============================================================
// Table 1 — Theme Ontology
// ============================================================
const t1Header = ["Style", "Background", "Grid", "Frame", "Font", "Ticks", "Legend"];
const t1Rows = [
  ["Prism", "White", "Off", "Black box", "Sans (Arial)", "Outward", "Right"],
  ["SPSS", "White", "Light grey", "Black box", "Sans (Arial)", "Inward", "Right"],
  ["OriginPro", "White", "Off", "Black box", "Sans (Arial)", "Outward", "Right, boxed"],
  ["Stata s2color", "Light blue tint", "Bluish, thin", "Grey, thin", "Sans", "Inward", "Right"],
  ["Academic", "White", "Off", "None (axes only)", "Sans", "Inward", "Bottom"],
  ["SigmaPlot", "White", "Off", "Black box", "Sans (Arial)", "Inward", "Right, boxed"],
  ["JMP", "White", "Off", "None (axes only)", "Sans (Arial)", "Outward", "Bottom"],
  ["MATLAB", "White", "Off", "Black box", "Sans (Helvetica)", "Inward", "Right"],
  ["Minitab", "Light grey", "Off", "Dark blue box", "Sans (Arial)", "Inward", "Right, boxed"],
  ["MedCalc", "White", "Light grey", "Black box", "Sans (Arial)", "Inward", "Inside plot"]
];
const t1Widths = [1400, 1600, 1200, 1600, 1400, 1000, 1300];

const t1_ontology = new Table({
  width: { size: 9500, type: WidthType.DXA },
  columnWidths: t1Widths,
  rows: [
    // Top thick line row
    new TableRow({ children: t1Header.map((h, i) => new TableCell({
      borders: topBorders, width: { size: t1Widths[i], type: WidthType.DXA },
      margins: { top: 60, bottom: 80, left: 100, right: 100 },
      children: [new Paragraph({ spacing: { after: 0 }, alignment: AlignmentType.CENTER,
        children: [new TextRun({ text: h, font: "Arial", size: 18, bold: true })] })]
    })) }),
    // Header cells with bottom thin line
    new TableRow({ children: t1Header.map((h, i) => new TableCell({
      borders: headBorders, width: { size: t1Widths[i], type: WidthType.DXA },
      margins: { top: 40, bottom: 60, left: 100, right: 100 },
      children: [new Paragraph({ spacing: { after: 0 } })]
    })) }),
    // Data rows
    ...t1Rows.map((row, ri) => {
      const isLast = ri === t1Rows.length - 1;
      return new TableRow({
        children: row.map((cell, ci) => new TableCell({
          borders: isLast ? bottomBorders : midBorders,
          width: { size: t1Widths[ci], type: WidthType.DXA },
          margins: { top: 30, bottom: 30, left: 100, right: 100 },
          children: [new Paragraph({ spacing: { after: 0 },
            children: [new TextRun({ text: cell, font: "Arial", size: 17 })] })]
        }))
      });
    })
  ]
});

// ============================================================
// Table 2 — Compliance Assessment
// ============================================================
const t2Header = ["Style", "CVD Safety", "Grayscale", "CMYK", "Overall", "Key Limitation"];
const t2Rows = [
  ["Academic", "5", "5", "5", "5.0", "None — grayscale is universally accessible"],
  ["SigmaPlot", "5", "5", "5", "5.0", "None — B&W/grayscale default"],
  ["MATLAB R2014b+", "3", "4", "4", "3.7", "Orange-yellow-green still marginal"],
  ["Prism", "3", "3", "4", "3.3", "Adjacent blues may merge"],
  ["SPSS", "2", "3", "4", "3.0", "Red-green CVD confusion"],
  ["Stata s2color", "2", "3", "4", "3.0", "Maroon-forest green confusable"],
  ["JMP", "2", "3", "4", "3.0", "Red-green; blue-purple for tritanopia"],
  ["Minitab", "2", "3", "4", "3.0", "Red-olive; blue-purple pairs merge"],
  ["MedCalc", "2", "3", "4", "3.0", "Red-green confusion"],
  ["OriginPro", "1", "2", "2", "1.7", "Pure RGB primaries; out of CMYK gamut"]
];
const t2Widths = [1600, 1200, 1200, 1200, 1200, 3000];

const t2_compliance = new Table({
  width: { size: 9500, type: WidthType.DXA },
  columnWidths: t2Widths,
  rows: [
    new TableRow({ children: t2Header.map((h, i) => new TableCell({
      borders: topBorders, width: { size: t2Widths[i], type: WidthType.DXA },
      margins: { top: 60, bottom: 80, left: 100, right: 100 },
      children: [new Paragraph({ spacing: { after: 0 }, alignment: AlignmentType.CENTER,
        children: [new TextRun({ text: h, font: "Arial", size: 18, bold: true })] })]
    })) }),
    new TableRow({ children: t2Header.map((h, i) => new TableCell({
      borders: headBorders, width: { size: t2Widths[i], type: WidthType.DXA },
      margins: { top: 40, bottom: 60, left: 100, right: 100 },
      children: [new Paragraph({ spacing: { after: 0 } })]
    })) }),
    ...t2Rows.map((row, ri) => {
      const isLast = ri === t2Rows.length - 1;
      return new TableRow({
        children: row.map((cell, ci) => new TableCell({
          borders: isLast ? bottomBorders : midBorders,
          width: { size: t2Widths[ci], type: WidthType.DXA },
          margins: { top: 30, bottom: 30, left: 100, right: 100 },
          children: [new Paragraph({ spacing: { after: 0 },
            children: [new TextRun({
              text: cell, font: "Arial", size: 17,
              bold: ci >= 1 && ci <= 4
            })] })]
        }))
      });
    })
  ]
});

// ============================================================
// Text helpers
// ============================================================
let lineNum = 0;
const ln = () => { lineNum++; return ""; };

const p = (text, opts = {}) => {
  const r = new Paragraph({
    spacing: { after: 120, line: 276 },
    children: [new TextRun({ text: ln() + text, font: "Arial", size: 22, ...opts })]
  });
  lineNum += Math.ceil(text.length / 80);
  return r;
};

const h1 = (text) => new Paragraph({
  heading: HeadingLevel.HEADING_1, spacing: { before: 360, after: 200 },
  children: [new TextRun({ text, bold: true, font: "Arial", size: 28 })]
});

const h2 = (text) => new Paragraph({
  heading: HeadingLevel.HEADING_2, spacing: { before: 280, after: 140 },
  children: [new TextRun({ text, bold: true, font: "Arial", size: 24 })]
});

const cite = (nums) => new TextRun({ text: ` [${nums}]`, font: "Arial", size: 20, color: "555555" });

const caption = (text) => new Paragraph({
  spacing: { after: 60, before: 240 },
  children: [new TextRun({ text, font: "Arial", size: 20, italics: true })]
});

const emptyLine = () => new Paragraph({ spacing: { after: 0 }, children: [] });

// ============================================================
// Document Content
// ============================================================
const children = [];

// ---- TITLE PAGE ----
children.push(emptyLine());
children.push(emptyLine());
children.push(new Paragraph({
  alignment: AlignmentType.CENTER, spacing: { after: 200 },
  children: [new TextRun({ text: "multiplot: Emulating statistical plot styles across nine graphing software packages and an academic publication style in R", bold: true, font: "Arial", size: 32 })]
}));
children.push(new Paragraph({
  alignment: AlignmentType.CENTER, spacing: { after: 80 },
  children: [new TextRun({ text: "Shuqiong Su, Aiqun Liu*", font: "Arial", size: 24 })]
}));
children.push(new Paragraph({
  alignment: AlignmentType.CENTER, spacing: { after: 80 },
  children: [new TextRun({ text: "Software Tool Article — F1000Research", font: "Arial", size: 20, italics: true, color: "666666" })]
}));
children.push(new PageBreak());

// ---- ABSTRACT ----
children.push(h1("Abstract"));
children.push(p("Researchers in biomedicine routinely move between different graphing tools—GraphPad Prism for pharmacology, SPSS for survey analysis, OriginPro for multi-panel figures, Stata for econometric plots, and MATLAB for engineering visualizations. Each tool has a distinctive default visual style: its own combination of background colour, grid presence, font choice, and palette. These defaults become second nature to regular users, and manuscripts reviewed by someone accustomed to one tool's appearance can feel unfamiliar when figures are produced with another."));
children.push(p("Here we introduce multiplot, an R package built on ggplot2 that captures nine software-derived graphing styles plus one academic publication style. The package reduces the entire style of any supported target to a single function call: ggchoice(\"prism\") applies the GraphPad Prism look, ggchoice(\"spss\") the SPSS look, and so on. Each call bundles a complete theme, a discrete colour scale, and a discrete fill scale. Because ggplot2's layering rules give later additions priority, users can freely override any scale after ggchoice() without losing the theme."));
children.push(p("Beyond the software itself, we contribute a formal Plot Style Ontology that decomposes each supported style into five dimensions—Theme, Palette, Geom, Annotation, and Convention—and a systematic assessment of each default palette against three publication compliance criteria: colour vision deficiency safety, grayscale print fidelity, and CMYK gamut compatibility. Among the ten supported defaults examined, only grayscale-based styles (Academic, SigmaPlot) earned perfect scores across all three dimensions. The most common vulnerability was red-green confusion, affecting eight of ten default palettes."));
children.push(p("multiplot exports 29 functions, requires only ggplot2 (>= 3.4.0), contains no compiled code, and is distributed under the MIT license from https://github.com/sushuqiong/multiplot."));
children.push(new PageBreak());

// ---- INTRODUCTION ----
children.push(h1("Introduction"));
children.push(p("Walk through any biomedical research department and you will find a patchwork of graphing software. A pharmacology lab might swear by GraphPad Prism for its dose-response curves and built-in statistical comparisons. The epidemiologists next door likely produce their survey-weighted bar charts in SPSS. The bioinformatics group prefers ggplot2 in R for its flexibility, while the engineers down the hall run MATLAB for signal processing plots. Each community develops a deep familiarity with the default look of its primary tool—the particular shade of blue on a Prism column, the light grey grid behind an SPSS bar chart, the Navy-Maroon-Forest Green colour cycle of Stata's s2color scheme."));
children.push(p("When researchers from these different traditions collaborate on a manuscript, something mundane but frustrating happens: the figures look wrong. Not because the underlying statistics are flawed, but because the visual conventions differ from what each reader expects. A reviewer who has spent twenty years reading SPSS output may find an R-generated ggplot unfamiliar even when the data presentation is technically correct. Meanwhile, a computationally reproducible analysis pipeline in R produces output that does not match the visual norms of the target journal or the expectations of co-authors who work primarily in other tools."));
children.push(p("Several R packages have addressed pieces of this problem. ggprism", cite("1"), "provides excellent GraphPad Prism-inspired themes and palettes but covers only that one software. r2spss", cite("2"), "replicates SPSS output formatting, including both legacy and modern SPSS graph styles, but is similarly focused on a single tool. ggthemes", cite("3"), "offers themes inspired by publications and software tools but prioritizes variety over fidelity to any particular software's defaults. cowplot", cite("4"), "provides a clean, publication-ready default theme without attempting to emulate specific software. None of these packages offers broad multi-style coverage, a formal vocabulary for reasoning about what makes one style different from another, or guidance on which default styles meet accessibility standards for publication."));
children.push(p("multiplot fills these three gaps at once: it covers nine graphing software packages and one academic publication style with a single-function interface, it formalises the notion of a plotting style through a five-component ontology, and it provides a systematic compliance benchmark that helps researchers choose styles appropriate for colour-blind readers, grayscale printing, and CMYK reproduction. The package is designed to sit cleanly on top of ggplot2 without modifying its internals, so it coexists with any other ggplot2 extension."));
children.push(new PageBreak());

// ---- METHODS ----
children.push(h1("Methods"));

children.push(h2("Implementation"));
children.push(p("multiplot is a pure R package with a simple layered architecture. At the bottom layer, ten internal theme_xxx() functions inherit from theme_bw() or theme_classic() and override panels, grids, borders, fonts, legends, and strip formatting to match each target software's default output. Parallel to these, twenty internal discrete scale_color/fill_xxx() functions define qualitative palettes extracted from the software's documented default colour order. Fourteen additional continuous scale functions (scale_color/fill_xxx_c()) provide software-specific sequential and diverging gradients for heatmaps and surfaces—for example, scale_fill_matlab_c() approximates MATLAB's parula colormap with nine keypoints."));
children.push(p("The top layer consists of a single entry point, ggchoice(style), that bundles a theme, a colour scale, and a fill scale into one call. Because ggchoice() returns a list, and ggplot2 resolves conflicts in favour of later additions, users can add their own scale calls after ggchoice() to override the defaults without touching the theme. This additive design preserves ggplot2's composability while providing sensible starting points."));
children.push(p("The package also exports three convenience functions: geom_errorbar_prism() and geom_col_prism(), which set Prism-appropriate defaults for error bars (wider T-shaped caps) and column bars (solid fill with a thin black border); and stat_compare_means_prism(), a wrapper around ggpubr::stat_compare_means() that formats p-values with the cutoffs and significance stars used by GraphPad Prism."));

children.push(h2("Operation"));
children.push(p("The package requires R >= 4.0 and ggplot2 >= 3.4.0. Installation from GitHub uses remotes::install_github(\"sushuqiong/multiplot\"). No compilation is needed, and the only hard dependency is ggplot2 (ggpubr is optional, required only for stat_compare_means_prism())."));

children.push(h2("Style extraction and verification"));
children.push(p("Default visual parameters for the nine software-derived styles were extracted from official documentation and user guides, default scheme or theme definition files (e.g., Stata's scheme-s2color.scheme, MATLAB's ColorOrder specification), direct software output inspection where available, and published descriptions in the methodology literature", cite("5,6"), ". For Prism, SPSS, and MATLAB, our theme implementations were verified against actual software screenshots. Three discrepancies were caught and corrected during this process: Prism axis ticks point outward (not inward as we initially assumed), SPSS includes a light grey background grid (not a blank canvas), and MATLAB draws a full outer box frame (not internal axes only). The remaining software-derived styles were checked against documentation and scheme files where available; the Academic style was treated as an internally defined publication-oriented benchmark rather than a software default."));
children.push(new PageBreak());

// ---- RESULTS / USE CASES ----
children.push(h1("Use Cases"));

children.push(p("Figures 1 through 7 illustrate the range of styles and plot types supported by multiplot. All figures were generated with the package and require only the code shown in the figure captions."));

children.push(caption("Figure 1. Ten-style boxplot comparison. The same underlying data (mpg dataset: highway fuel economy by vehicle class) rendered in all ten supported styles. Each panel differs only in its ggchoice() call; no manual theme adjustment was used."));
children.push(p("[Figure 1 — see figures/Figure1.pdf]", { italics: true, size: 20 }));

children.push(caption("Figure 2. Prism-style bar chart with T-shaped error bars. The bar uses geom_col_prism() (solid fill, thin black border, compact width) and the error bars use geom_errorbar_prism() (wider cap for the characteristic Prism T-bar appearance). The overall style is set by ggchoice(\"prism\")."));
children.push(p("[Figure 2 — see figures/Figure2.pdf]", { italics: true, size: 20 }));

children.push(caption("Figure 3. SPSS-style scatter plot of vehicle weight against fuel economy (mtcars dataset). Points are coloured by engine cylinder count. ggchoice(\"spss\") applies the muted, professional SPSS palette with #3E58AC blue dominant, light grey grid, and centred bold title."));
children.push(p("[Figure 3 — see figures/Figure3.pdf]", { italics: true, size: 20 }));

children.push(caption("Figure 4. Continuous colour scales for heatmap data. Panel A uses ggchoice(\"matlab\") with scale_fill_matlab_c() to approximate the parula colormap; Panel B uses ggchoice(\"academic\") with scale_fill_academic_c() for a CVD-safe, grayscale-compatible grayscale gradient."));
children.push(p("[Figure 4 — see figures/Figure4.pdf]", { italics: true, size: 20 }));

children.push(caption("Figure 5. OriginPro-style density distributions of highway fuel economy, grouped by vehicle class. Semi-transparent fills and the Black-Red-Green-Blue palette mimic Origin's classic multi-curve appearance. The legend is framed in a box as per Origin convention."));
children.push(p("[Figure 5 — see figures/Figure5.pdf]", { italics: true, size: 20 }));

children.push(caption("Figure 6. Minitab-style faceted scatter plot of engine displacement against fuel economy. Each vehicle class occupies its own panel. The light grey background (#F5F5F5) and dark blue (#1F497D) frame lines are characteristic of Minitab's default graph output."));
children.push(p("[Figure 6 — see figures/Figure6.pdf]", { italics: true, size: 20 }));

children.push(caption("Figure 7. Scale override demonstration. The theme is set to Prism via ggchoice(\"prism\"), but the fill scale is overridden by scale_fill_brewer(palette = \"Set2\")—a user-supplied ColorBrewer palette that replaces the default Prism colours. Because ggplot2 resolves conflicts in favour of later additions, the user's scale takes priority while the Prism theme (white background, no grid, black frame, outward ticks, sans-serif font) remains intact."));
children.push(p("[Figure 7 — see figures/Figure7.pdf]", { italics: true, size: 20 }));
children.push(new PageBreak());

// ---- TABLE 1 ----
children.push(h2("Table 1. Plot Style Ontology — Theme Dimensions"));
children.push(p("The table below summarises the theme-level parameters for all ten supported styles. Software-derived rows describe the target software's factory configuration where available; Academic is an internally defined publication-oriented benchmark. Full palette, geom, annotation, and convention dimensions are documented in the package vignette and supplementary materials."));
children.push(t1_ontology);
children.push(emptyLine());

// ---- TABLE 2 ----
children.push(h2("Table 2. Publication Compliance Assessment"));
children.push(p("Each supported style's default discrete palette was scored from 1 (poor) to 5 (excellent) for colour vision deficiency safety (deuteranopia, protanopia, and tritanopia), grayscale print fidelity (CIELAB L* separation under D65 illuminant), and CMYK gamut compatibility (Delta E to ISO Coated v2 profile). An overall score is the arithmetic mean of the three dimensions."));
children.push(t2_compliance);
children.push(new PageBreak());

// ---- DISCUSSION ----
children.push(h1("Discussion"));
children.push(p("The idea that drove this project is simple: if a researcher can switch software with one keystroke, they should be able to switch a plot's visual style just as easily. ggchoice() turns what would otherwise require remembering a dozen theme and scale functions into a single, discoverable call."));
children.push(p("The Plot Style Ontology formalises something that experienced data visualizers know intuitively—that a graphing tool's \"look\" is not a single property but a bundle of independent dimensions. By making those dimensions explicit, the ontology serves both as a design document (it told us exactly which parameters to extract from each software-derived style) and as a pedagogical tool (it gives researchers a vocabulary for describing why a Prism plot looks different from an SPSS plot). The ontology also reveals that no two supported styles in our set share an identical 5-tuple, confirming that each defaults to a genuinely distinctive visual identity rather than a minor variation on a common template."));
children.push(p("The compliance assessment results carry a clear practical message: among the ten default palettes we examined, only the two grayscale-based styles (Academic and SigmaPlot) are safe for all common forms of colour vision deficiency and print production. The other eight all exhibit some degree of red-green confusability, the most prevalent form of CVD. This is not a criticism of the software vendors—their defaults were designed for on-screen viewing in an era before accessibility standards were widely adopted—but it is a reason for researchers to choose their plotting style deliberately rather than accepting whatever default their software provides."));
children.push(p("Several limitations should be acknowledged. First, direct screenshot verification currently covers three of the nine software-derived styles (Prism, SPSS, MATLAB), with additional documentation, template, or selected-plot checks for the remaining software-derived styles. Second, software defaults evolve: SPSS 25 introduced a modern chart engine with updated styling, and Stata 18 replaced s2color with the stcolor scheme. Third, our continuous colour scales use fixed keypoint interpolation rather than the exact algorithmic colour maps of the original software. Finally, multiplot covers only two-dimensional static ggplot2 output; interactive features such as JMP's hover tooltips or Prism's linked analyses lie outside its scope."));
children.push(p("Future work will extend the package in two directions. First, a formal perceptual fidelity study (N >= 20 human raters) will compare multiplot output side-by-side with real software screenshots across all ten packages. Second, journal-specific templates—Nature, Cell, Science, The Lancet—can be built on the Academic base, incorporating each journal's specific font, dimension, and colour requirements. A Shiny gadget for interactive style preview would also lower the barrier for researchers new to R who want to explore the package's capabilities without writing code."));
children.push(new PageBreak());

// ---- DATA AND SOFTWARE AVAILABILITY ----
children.push(h1("Data and software availability"));
children.push(p("Source code: https://github.com/sushuqiong/multiplot"));
children.push(p("Archived package: multiplot v0.3.2. Version DOI: https://doi.org/10.5281/zenodo.21239178; concept DOI: https://doi.org/10.5281/zenodo.21137144."));
children.push(p("License: MIT"));
children.push(p("R package dependencies: ggplot2 (>= 3.4.0); ggpubr (optional)"));
children.push(p("All data used in the examples are distributed with R or with the R packages used in the examples. Example code to reproduce all figures is available in the package vignette and in inst/examples/multiplot_demo.R in the repository."));

// ---- ACKNOWLEDGEMENTS ----
children.push(h1("Acknowledgements"));
children.push(p("The authors thank the developers of ggprism and r2spss, whose packages demonstrated the feasibility of single-software ggplot2 theme emulation and provided reference implementations for the Prism and SPSS styles. The MATLAB parula keypoints were derived from the official MathWorks parula specification."));

// ---- REFERENCES ----
children.push(new PageBreak());
children.push(h1("References"));
const refs = [
  "Dawson C: ggprism: A ggplot2 Extension Inspired by GraphPad Prism. R package version 1.0.7. 2025.",
  "Alfons A: r2spss: Format R Output to Look Like SPSS. R package version 0.3.2. 2022.",
  "Arnold JB: ggthemes: Extra Themes, Scales and Geoms for ggplot2. R package version 5.1.0. 2024.",
  "Wilke CO: cowplot: Streamlined Plot Theme and Plot Annotations for ggplot2. R package version 1.2.0. 2025.",
  "Crameri F, Shephard GE, Heron PJ: The misuse of colour in science communication. Nat Commun. 2020; 11(1): 5444.",
  "Stauffer R, Mayr GJ, Dabernig M, et al.: Somewhere over the rainbow: How to make effective use of colors in meteorological visualizations. Bull Am Meteorol Soc. 2015; 96(2): 203-216.",
  "Birch J: Worldwide prevalence of red-green color deficiency. J Opt Soc Am A. 2012; 29(3): 313-320.",
  "Zeileis A, Fisher JC, Hornik K, et al.: colorspace: A toolbox for manipulating and assessing colors and palettes. J Stat Softw. 2020; 96(1): 1-49.",
  "Pedersen TL, Nicolae B, Francois R: farver: High performance colour space manipulation. R package version 2.1.2. 2024.",
  "Weissgerber TL, Milic NM, Winham SJ, et al.: Beyond bar and line graphs: time for a new data presentation paradigm. PLoS Biol. 2015; 13(4): e1002128."
];
refs.forEach((r, i) => {
  children.push(new Paragraph({
    spacing: { after: 80 }, indent: { left: 360, hanging: 360 },
    children: [
      new TextRun({ text: `${i + 1}. `, font: "Arial", size: 18, bold: true }),
      new TextRun({ text: r, font: "Arial", size: 18 })
    ]
  }));
});

// ============================================================
// Assemble Document
// ============================================================
const doc = new Document({
  styles: {
    default: { document: { run: { font: "Arial", size: 22 } } },
    paragraphStyles: [
      { id: "Heading1", name: "Heading 1", basedOn: "Normal", next: "Normal", quickFormat: true,
        run: { size: 28, bold: true, font: "Arial" },
        paragraph: { spacing: { before: 320, after: 160 }, outlineLevel: 0 } },
      { id: "Heading2", name: "Heading 2", basedOn: "Normal", next: "Normal", quickFormat: true,
        run: { size: 24, bold: true, font: "Arial" },
        paragraph: { spacing: { before: 240, after: 120 }, outlineLevel: 1 } }
    ]
  },
  sections: [{
    properties: {
      page: {
        size: { width: 12240, height: 15840 },
        margin: { top: 1440, right: 1440, bottom: 1440, left: 1800 }
      }
    },
    headers: {
      default: new Header({
        children: [new Paragraph({
          alignment: AlignmentType.RIGHT,
          children: [new TextRun({ text: "multiplot — F1000Research Software Tool Article", font: "Arial", size: 16, italics: true, color: "888888" })]
        })]
      })
    },
    footers: {
      default: new Footer({
        children: [new Paragraph({
          alignment: AlignmentType.CENTER,
          children: [
            new TextRun({ text: "Page ", font: "Arial", size: 16, color: "888888" }),
            new TextRun({ children: [PageNumber.CURRENT], font: "Arial", size: 16, color: "888888" })
          ]
        })]
      })
    },
    children
  }]
});

// Write
const outPath = "C:/Users/fengq/Desktop/multiplot_F1000Research.docx";
Packer.toBuffer(doc).then(buffer => {
  fs.writeFileSync(outPath, buffer);
  console.log("Document written to " + outPath);
  console.log("Size: " + (buffer.length / 1024).toFixed(1) + " KB");
});
