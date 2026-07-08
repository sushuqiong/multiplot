const fs = require("fs");
const {Document, Packer, Paragraph, TextRun, Table, TableRow, TableCell,
  Header, Footer, AlignmentType, HeadingLevel, BorderStyle, WidthType,
  ShadingType, PageNumber, PageBreak, ImageRun} = require("docx");

const thick = {style: BorderStyle.SINGLE, size: 12, color: "000000"};
const thin  = {style: BorderStyle.SINGLE, size: 6,  color: "000000"};
const none  = {style: BorderStyle.SINGLE, size: 1,  color: "FFFFFF"};
const topB = {top: thick, bottom: none, left: none, right: none};
const headB = {top: none, bottom: thin, left: none, right: none};
const midB = {top: none, bottom: none, left: none, right: none};
const botB = {top: none, bottom: thick, left: none, right: none};

function hdrCell(t, w, sz) { return new TableCell({
  borders: topB, width: {size: w, type: WidthType.DXA},
  margins: {top: 60, bottom: 60, left: 80, right: 80},
  children: [new Paragraph({spacing:{after:0}, alignment:AlignmentType.CENTER,
    children: [new TextRun({text: t, font: "Arial", size: sz||18, bold: true})]})]
});}
function hdrSep(w) { return new TableCell({
  borders: headB, width: {size: w, type: WidthType.DXA},
  margins: {top: 30, bottom: 40, left: 80, right: 80},
  children: [new Paragraph({spacing:{after:0}, children: []})]
});}
function datCell(t, w, sz, last) { return new TableCell({
  borders: last ? botB : midB, width: {size: w, type: WidthType.DXA},
  margins: {top: 35, bottom: 35, left: 80, right: 80},
  children: [new Paragraph({spacing:{after:0}, children: [new TextRun({
    text: t, font: "Arial", size: sz||17})]})]
});}

const t1H = ["Style","Evidence","Background","Grid","Frame","Font","Ticks","Legend"];
const t1W = [1200,900,1500,1200,1400,1200,900,1200];
const t1D = [
  ["Prism","A","White","Off","Black box","Sans","Outward","Right"],
  ["SPSS","A","White","Light grey","Black box","Sans","Inward","Right"],
  ["OriginPro","B","White","Off","Black box","Sans","Outward","Right, boxed"],
  ["Stata s2color","B","Light bluish #F4F7FA","Horizontal bluish","Grey, thin","Sans","Inward","Bottom"],
  ["Academic","D","White","Off","None (axes)","Sans","Inward","Bottom"],
  ["SigmaPlot","B","White","Off","Black box","Sans","Inward","Right, boxed"],
  ["JMP","B","White","Off","None (axes)","Sans","Outward","Bottom"],
  ["MATLAB","A","White","Off","Black box","Sans","Inward","Right"],
  ["Minitab","B","Light grey #F5F5F5","Off","Dark blue box","Sans","Inward","Right, boxed"],
  ["MedCalc","B","White","Very thin grey","Black box","Sans","Inward","Inside plot"]
];
const t1 = new Table({width:{size:9500,type:WidthType.DXA}, columnWidths:t1W, rows:[
  new TableRow({children: t1H.map((h,i)=>hdrCell(h,t1W[i],18))}),
  new TableRow({children: t1W.map(w=>hdrSep(w))}),
  ...t1D.map((row,ri)=>new TableRow({children: row.map((c,ci)=>datCell(c,t1W[ci],17,ri===t1D.length-1))}))
]});

const t2H = ["Style","CVD","Grayscale","Print","Overall","Key limitation"];
const t2W = [1600,1200,1200,1200,1200,3000];
const t2D = [
  ["Academic","5","5","5","5.0","Universally accessible"],
  ["SigmaPlot","5","5","5","5.0","B&W/grayscale default"],
  ["MATLAB R2014b+","3","4","5","4.0","Orange-yellow-green marginal"],
  ["Minitab","3","3","5","3.7","Red-olive and blue-purple can merge"],
  ["Prism","3","3","4","3.3","Adjacent blues may merge"],
  ["SPSS","2","3","5","3.3","CVD separability limited"],
  ["Stata s2color","2","4","4","3.3","Maroon-forest green confusable"],
  ["MedCalc","2","3","5","3.3","Red-green confusion"],
  ["JMP","2","3","4","3.0","Red-green; blue-purple for tritanopia"],
  ["OriginPro","1","4","2","2.3","Pure RGB primaries; print risk"]
];
const t2 = new Table({width:{size:9500,type:WidthType.DXA}, columnWidths:t2W, rows:[
  new TableRow({children: t2H.map((h,i)=>hdrCell(h,t2W[i],18))}),
  new TableRow({children: t2W.map(w=>hdrSep(w))}),
  ...t2D.map((row,ri)=>new TableRow({children: row.map((c,ci)=>datCell(c,t2W[ci],17,ri===t2D.length-1))}))
]});

const body = (t, o) => new Paragraph({
  spacing: {after: 120, line: 276},
  children: [new TextRun({text: t, font: "Arial", size: (o&&o.sz)||22})]
});
const H1 = (t) => new Paragraph({heading:HeadingLevel.HEADING_1,spacing:{before:360,after:200},children:[new TextRun({text:t,bold:true,font:"Arial",size:28})]});
const H2 = (t) => new Paragraph({heading:HeadingLevel.HEADING_2,spacing:{before:280,after:140},children:[new TextRun({text:t,bold:true,font:"Arial",size:24})]});
const PL = () => new Paragraph({spacing:{after:0},children:[]});
const BR = () => new Paragraph({children:[new PageBreak()]});
const FIGCAP = (t) => new Paragraph({spacing:{after:80,before:240},children:[new TextRun({text:t,font:"Arial",size:20,italics:true})]});
const FIGDIR = "C:/Users/fengq/Desktop/开发R包multiplot/figures";
const figurePreview = [
  {n: 1, w: 560, h: 280, cap: "Figure 1. Ten-style boxplot comparison."},
  {n: 2, w: 560, h: 400, cap: "Figure 2. Prism-style bar chart with T-bar error bars."},
  {n: 3, w: 560, h: 350, cap: "Figure 3. Prism-style scatter plot with shape mapping and axis offset."},
  {n: 4, w: 560, h: 350, cap: "Figure 4. Prism-style violin plot with boxplot overlay."},
  {n: 5, w: 560, h: 350, cap: "Figure 5. SPSS-style line chart with point shapes."},
  {n: 6, w: 560, h: 233, cap: "Figure 6. Continuous colour scales for heatmap data."},
  {n: 7, w: 560, h: 350, cap: "Figure 7. Scale override and axis offset demonstration."},
  {n: 8, w: 560, h: 350, cap: "Figure 8. Stata s2color scatter plot."},
  {n: 9, w: 560, h: 350, cap: "Figure 9. OriginPro-style multi-group density plot."},
  {n: 10, w: 560, h: 350, cap: "Figure 10. SPSS-style Kaplan-Meier survival curve."}
];

function imageParagraph(path, width, height) {
  return new Paragraph({
    alignment: AlignmentType.CENTER,
    spacing: {before: 120, after: 160},
    children: [new ImageRun({
      data: fs.readFileSync(path),
      transformation: {width, height}
    })]
  });
}

const C = [];

// ---- TITLE PAGE ----
C.push(PL(), PL(), PL());
C.push(new Paragraph({alignment:AlignmentType.CENTER, spacing:{after:200},
  children: [new TextRun({text:"multiplot: Approximating statistical plot styles across nine graphing software packages and an academic publication style in R",bold:true,font:"Arial",size:32})]}));
C.push(new Paragraph({alignment:AlignmentType.CENTER, spacing:{after:80},
  children: [new TextRun({text:"Shuqiong Su, Shiyao Yang, Guozhen Chen, Aiqun Liu*",font:"Arial",size:26})]}));
C.push(new Paragraph({alignment:AlignmentType.CENTER, spacing:{after:80},
  children: [new TextRun({text:"Department of Gastroenterology, Guangxi Medical University Cancer Hospital, Nanning, Guangxi, China",font:"Arial",size:20,italics:true,color:"555555"})]}));
C.push(new Paragraph({alignment:AlignmentType.CENTER, spacing:{after:40},
  children: [new TextRun({text:"*Corresponding author: Aiqun Liu. Email: liuaiqun_2004@163.com",font:"Arial",size:20,color:"555555"})]}));
C.push(BR());

// ---- ABSTRACT ----
C.push(H1("Abstract"));
C.push(body("Background",{sz:22}));
C.push(body("Biomedical researchers routinely switch between different graphing tools—GraphPad Prism, SPSS, OriginPro, Stata, MATLAB, and others—each with a distinctive default visual style. This heterogeneity creates two practical problems: researchers and reviewers accustomed to one software’s conventions may perceive figures produced with another tool as unfamiliar, and computationally reproducible pipelines in R produce output that may not match a journal’s or co-author’s visual expectations."));
C.push(body("Methods",{sz:22}));
C.push(body("We developed multiplot, an open-source R package built on ggplot2, that provides software-derived style approximation layers for nine widely used statistical graphing packages together with an additional academic publication style. Each style is applied through a single function call, ggchoice(), which by default bundles a complete theme, discrete colour scale, and discrete fill scale; advanced users can request theme-only output with include_scales = FALSE. We formalised each supported style into a five-component Plot Style Ontology ({Theme, Palette, Geom, Annotation, Convention}) and extracted the relevant parameters from official documentation, default scheme files, and direct software output inspection. Each default palette was assessed against colour vision deficiency (CVD) safety, grayscale print fidelity, and approximate print-colour risk."));
C.push(body("Results",{sz:22}));
C.push(body("The package exports 29 user-facing functions, is implemented entirely in R, and uses ggplot2 as its only required package for core plotting functionality. Three of the nine software-derived styles (Prism, SPSS, MATLAB) were verified against real software screenshots, identifying three corrections: Prism axis ticks point outward, SPSS includes a light grey background grid, and MATLAB draws a full outer box frame. The remaining software-derived styles were checked against official documentation, user guides, scheme files, or selected screenshots where available, while the Academic style was treated as an internally defined publication-oriented benchmark. The compliance assessment showed that the grayscale-oriented Academic and SigmaPlot styles achieved the maximum scores in this benchmark; the most common vulnerability was reduced colour separability under simulated colour vision deficiency, including red-green confusion in several colour-based palettes."));
C.push(body("Conclusions",{sz:22}));
C.push(body("multiplot fills a gap between single-software theme packages and general-purpose ggplot2 extensions by providing, to our knowledge, a multi-software ggplot2 style approximation tool with a formal ontology framework and built-in publication compliance guidance."));
C.push(BR());
C.push(H1("Keywords"));
C.push(body("data visualization; ggplot2; R package; statistical graphics; GraphPad Prism; SPSS; colour vision deficiency; reproducible research",{sz:20}));
C.push(BR());

// ---- INTRODUCTION ----
C.push(H1("Introduction"));
C.push(body("The landscape of statistical graphing software in biomedical research is strikingly fragmented. A pharmacology lab may rely exclusively on GraphPad Prism for its dose-response curves and built-in statistical comparisons. The epidemiologists next door produce survey-weighted bar charts in SPSS. A bioinformatics group works entirely in ggplot2 for R, while engineering collaborators deliver MATLAB figures. Each community develops an intimate familiarity with its primary tool’s default visual conventions—the particular shade of blue on a Prism column, the light grey grid behind an SPSS bar chart, the Navy-Maroon-Forest Green colour cycle of Stata’s s2color scheme."));
C.push(body("When researchers from these different traditions collaborate, a mundane but persistent frustration arises: the figures can look unfamiliar—not because the statistics are flawed, but because the visual conventions differ from what each reader expects. A reviewer who has spent twenty years reading SPSS output may perceive an R-generated ggplot as unfamiliar even when the data are correctly presented. A computationally reproducible pipeline in R produces output that does not match the visual norms of the target journal or the expectations of co-authors who work in other tools [1]."));
C.push(body("Several R packages have tackled portions of this problem. ggprism [2] provides GraphPad Prism-inspired themes and palettes but covers only that single software. r2spss [3] replicates SPSS output formatting, including both legacy and modern graph styles, with similarly narrow scope. ggthemes [4] offers a broad collection of themes inspired by publications and software tools but prioritises variety over fidelity to any particular software’s defaults. cowplot [5] delivers a clean, publication-ready default theme without attempting to approximate specific tools. Weissgerber et al. [6] have argued that the research community must move beyond bar and line graphs toward more informative data presentation paradigms. None of these packages combines multi-software coverage, a formal vocabulary for describing style differences, and systematic guidance on which defaults meet accessibility standards."));
C.push(body("multiplot addresses all three gaps. It covers nine graphing software packages and one academic publication style through a single-function interface, formalises the concept of a plotting style through a five-component ontology, and provides a compliance benchmark that helps researchers choose styles appropriate for colour-blind readers, grayscale printing, and print-colour robustness. The package is designed to coexist with any other ggplot2 extension without modifying ggplot2 internals."));
C.push(BR());

// ---- METHODS ----
C.push(H1("Methods"));
C.push(H2("Implementation"));
C.push(body("multiplot is a pure R package with a layered architecture. At the bottom layer, ten internal theme_xxx() functions inherit from theme_bw() or theme_classic() and override panels, grids, borders, fonts, legends, and strip formatting to approximate each target software’s documented or inspected default output. Twenty internal discrete scale_color/fill_xxx() functions define qualitative palettes extracted from each software’s default colour order. Fourteen exported continuous scale functions (scale_color/fill_xxx_c()) provide software-specific sequential and diverging gradients for heatmaps and surfaces—for example, scale_fill_matlab_c() approximates MATLAB’s parula colormap with nine keypoints."));
C.push(body("The single entry point, ggchoice(style), bundles a theme, a colour scale, and a fill scale into one call. The include_scales = FALSE option returns only the theme (plus any requested axis-offset scales), allowing advanced users to retain their own colour or fill scales. An optional axis_offset parameter (for \"prism\" and \"spss\" styles) adds small continuous-scale expansion to create an axis separation gap at the origin. Because ggchoice() returns a list and ggplot2 resolves conflicts in favour of later additions, users can add their own scale calls after ggchoice() to override defaults without disturbing the theme; ggplot2’s standard \"Scale is already present\" message is expected in this use case. Several convenience functions round out the public API: geom_errorbar_prism(), geom_col_prism(), and geom_boxplot_prism() set Prism-appropriate defaults for error bars, column bars, and boxplots respectively; ten scale_shape_xxx() functions provide per-software point shape sequences; and stat_compare_means_prism() wraps ggpubr::stat_compare_means() with Prism-style p-value cutoffs and significance stars."));
C.push(body("The exported API can be grouped as follows: ggchoice() for style selection; geom_col_prism(), geom_errorbar_prism(), and geom_boxplot_prism() for Prism-style geoms; ten scale_shape_xxx() functions for software-derived marker sequences; fourteen continuous scale_color/fill_xxx_c() functions for heatmaps and gradients; and stat_compare_means_prism() for Prism-style statistical annotations. Discrete colour and fill palettes are applied internally by ggchoice(); when a plot contains more groups than the source palette length, colours are interpolated, while shape scales repeat their marker sequence."));
C.push(H2("Operation"));
C.push(body("The package requires R ≥ 4.0 and ggplot2 ≥ 3.4.0. Installation from GitHub uses remotes::install_github(\"sushuqiong/multiplot\"). No compilation step is needed. The only hard dependency is ggplot2; ggpubr is optional (required only for stat_compare_means_prism()), survival is listed in Suggests for the Kaplan-Meier demonstration in Figure 10, cowplot is listed in Suggests for arranging multi-panel demo figures, and colorspace/farver are analysis-only dependencies for the compliance benchmark. The package uses generic base_family = \"sans\" by default for cross-platform portability; exact Arial or Helvetica rendering depends on installed system fonts and the graphics device. Development checks use testthat and R CMD check via GitHub Actions."));
C.push(H2("Style extraction and verification"));
C.push(body("Default visual parameters for the nine software-derived styles were extracted from official documentation and user guides, default scheme or theme definition files, and direct software output inspection where available. Where a supplied screenshot did not include a software version, it is reported as a supplied screenshot with version not specified rather than being assigned a guessed version. The additional academic publication style was implemented as a grayscale-oriented benchmark style designed for accessibility and print robustness. Evidence levels are reported in Table 1: A indicates direct bar and box screenshots checked; B indicates selected screenshot or template plus documentation checks; D indicates an internally defined benchmark; no supported style was assigned level C in this version. For Prism, SPSS, and MATLAB, theme implementations were verified against actual software screenshots, resulting in three corrections: Prism axis ticks point outward, SPSS includes a light grey background grid, and MATLAB draws a full outer box frame. The remaining software-derived styles should be interpreted as documentation-based approximations rather than pixel-perfect reproductions. The complete five-component ontology mapping is provided in the extended data."));
C.push(BR());

// ---- RESULTS ----
C.push(H1("Results"));
C.push(H2("Plot Style Ontology"));
C.push(body("Table 1 summarises the theme-level parameters and evidence levels for all ten supported styles. Each cell represents the target default or benchmark setting for that dimension. No two styles share an identical combination of the theme-level attributes in Table 1, supporting the view that these are distinctive visual identities rather than minor permutations of a single default theme."));
C.push(H2("Table 1. Plot Style Ontology — Theme Dimensions"));
C.push(t1); C.push(PL());
C.push(H2("Compliance Assessment"));
C.push(body("Each supported style’s first five discrete palette colours were scored from 1 (poor) to 5 (excellent) across three publication-relevant dimensions. CVD safety was assessed by simulating each palette under deuteranopia, protanopia, and tritanopia with colorspace transformations based on Machado et al. [8]; Birch [7] is cited only for CVD prevalence. The CVD score uses the minimum pairwise CIE76 distance after simulation (grayscale palettes are treated as CVD-safe; critical pure red/green pairs are scored as high risk; otherwise ≥20=5, ≥15=4, ≥10=3, ≥4=2, <4=1). CIE76 is used here as a fast screening distance rather than a final prepress or perceptual-validation standard. Grayscale print fidelity uses CIELAB L* groups separated by at least 8 units, with total lightness-range checks. Print-colour risk uses a reproducible RGB saturation and pure-channel proxy rather than a bundled ICC profile, so it should be interpreted as a screening benchmark rather than a printer-specific prepress result. Scores are generated by inst/paper/compute_compliance_assessment.R using colorspace [9] and farver [10]. Overall is the arithmetic mean of the three dimension scores, rounded to one decimal place."));
C.push(H2("Table 2. Publication Compliance Assessment"));
C.push(t2); C.push(PL());
C.push(body("Only the two grayscale-oriented styles—Academic and SigmaPlot—achieved the maximum scores across all three assessed dimensions. MATLAB R2014b+ was the best-performing colour-based style in this benchmark. The most common failure mode was reduced separability under deuteranopia and protanopia simulations, including red-green confusability in several colour-based palettes. OriginPro’s classic palette, built from pure RGB primaries, performed worst because its pure red/green pair is critical for red-green CVD and its saturated primaries raise print-risk flags. As Crameri et al. [11] have documented, the misuse of colour in scientific communication remains widespread, and many software defaults were designed for on-screen viewing before accessibility standards were widely adopted. Researchers should therefore choose a plotting style deliberately rather than accepting whatever default their software provides."));
C.push(BR());

// ---- USE CASES ----
C.push(H1("Use Cases"));
C.push(body("Figures 1 through 10 illustrate the range of styles and plot types supported by multiplot. All examples use datasets distributed with R or commonly used R packages: mtcars and iris from base R, mpg from ggplot2, and lung from the survival package. No external data download is required. Beyond what is shown, multiplot provides per-software point shape scales (scale_shape_xxx()) that apply each tool’s default marker sequence, and an axis_offset parameter within ggchoice() that creates the axis separation gap characteristic of Prism and SPSS output."));
C.push(FIGCAP("Figure 1. Ten-style boxplot comparison. The same data (mpg: highway fuel economy by vehicle class) rendered in all ten supported styles using geom_boxplot_prism() + ggchoice(). Each panel differs only in its style argument; no manual theme adjustment was applied. X-axis labels are rotated 45 degrees."));
C.push(FIGCAP("Figure 2. Prism-style bar chart with T-bar error bars. Bars use geom_col_prism() (solid fill, thin black border); error bars use geom_errorbar_prism() (T-shaped caps). ggchoice(\"prism\") provides the clean white background and sans-serif typography."));
C.push(FIGCAP("Figure 3. Prism-style scatter plot with shape mapping and axis offset (iris dataset). Points use geom_point() with colour, fill, and shape aesthetics mapped to species. scale_shape_prism() applies the Prism default shape sequence (filled circle, square, triangle). ggchoice(\"prism\", axis_offset = TRUE) creates the characteristic Prism axis separation gap at the origin."));
C.push(FIGCAP("Figure 4. Prism-style violin plot with boxplot overlay. geom_violin() (semi-transparent fill) is combined with geom_boxplot_prism() (narrow, black-bordered). ggchoice(\"prism\") provides the clean white background and bold title characteristic of GraphPad Prism output."));
C.push(FIGCAP("Figure 5. SPSS-style line chart with point shapes. geom_line() + geom_point() with scale_shape_spss() applies the SPSS default shape sequence. The muted blue-dominant palette, light grey grid, and centred bold title match SPSS classic chart output."));
C.push(FIGCAP("Figure 6. Continuous colour scales for heatmap data. Panel A uses ggchoice(\"matlab\") + scale_fill_matlab_c() approximating the parula colormap. Panel B uses ggchoice(\"academic\") + scale_fill_academic_c() for a CVD-safe, grayscale-compatible sequential gradient."));
C.push(FIGCAP("Figure 7. Scale override and axis offset demonstration. The plot uses ggchoice(\"prism\", axis_offset = TRUE) for the Prism theme and axis gap, but scale_fill_brewer(palette = \"Set2\") replaces the default Prism colours with a ColorBrewer palette. Because ggplot2 resolves scale conflicts in favour of later additions, the user’s colour preference takes priority while all other Prism theme elements are preserved."));
C.push(FIGCAP("Figure 8. Stata s2color scatter plot (mtcars dataset). Points use the Stata default colour palette and shape sequence against a light bluish-tinted background with horizontal grid lines. Legend is positioned below the plot, matching Stata’s factory default."));
C.push(FIGCAP("Figure 9. OriginPro-style multi-group density plot. Semi-transparent fills are mapped to seven vehicle classes; because this exceeds the classic four-colour Origin cycle (Black, Red, Green, Blue), the discrete palette is interpolated to the required number of groups. ggchoice(\"origin\") applies the white background, outward ticks, and boxed legend characteristic of Origin’s default 2D graph output."));
C.push(FIGCAP("Figure 10. SPSS-style Kaplan-Meier survival curve. The lung cancer dataset (survival::lung) is stratified by sex (male vs female). The plot applies the SPSS-inspired theme with ggchoice(\"spss\", include_scales = FALSE) and manually specified blue/red sex colours, demonstrating theme-only use in a common biomedical survival-analysis example."));
C.push(BR());

// ---- DISCUSSION ----
C.push(H1("Discussion"));
C.push(body("The core idea behind multiplot is straightforward: if a researcher can switch between software tools with a few keystrokes, switching a plot’s visual style should be equally easy. ggchoice() turns what would otherwise require remembering a dozen theme and scale function names into a single, discoverable call."));
C.push(body("The Plot Style Ontology serves dual purposes. As a design document, it specifies which parameters are extracted from each software-derived or benchmark style. As a pedagogical tool, it gives researchers a vocabulary for describing why a Prism plot looks different from an SPSS plot—and which specific dimensions differ. Several distinctions are visible in Table 1: Stata’s s2color style uses a light bluish background (#F4F7FA) and horizontal-only grid lines; JMP and Academic both use axes-only framing; Minitab uses a light grey background (#F5F5F5) with a dark blue frame; and MedCalc places the legend inside the plot area for compact clinical-style displays. These observations are descriptive rather than claims about vendor intent. The fact that no two supported styles share an identical combination of the theme-level attributes in Table 1 supports the view that these are distinctive visual identities rather than minor permutations of a single default theme."));
C.push(body("The compliance benchmark carries a practical takeaway: if accessibility and print robustness are the primary priorities, ggchoice(\"academic\") and ggchoice(\"sigmaplot\") are the strongest options within this benchmark, because both received the maximum scores for CVD safety, grayscale fidelity, and print-colour robustness. This is not a criticism of the original software vendors—their defaults were designed in an era when on-screen appearance was the primary concern—but it is a reason to choose deliberately rather than accept factory settings."));
C.push(body("Several limitations warrant mention. First, direct bar/box screenshot verification currently covers three of the nine software-derived styles, with additional template or selected-plot checks for the remaining software-derived styles. This creates a risk that documentation-based approximations may miss version-specific defaults; future work should include community-contributed screenshots and a formal perceptual fidelity study. Second, software defaults evolve: SPSS 25 introduced a modern chart engine, and Stata 18 replaced s2color with stcolor. Third, our continuous colour scales use fixed keypoint interpolation rather than the exact algorithmic colormaps of the original software. Fourth, multiplot covers only two-dimensional static ggplot2 output and is not a full rendering engine for commercial graphing software. Planned future work includes journal-specific templates built on the Academic base and a Shiny gadget for interactive style preview."));
C.push(BR());

// ---- DATA AND SOFTWARE AVAILABILITY ----
C.push(H1("Data and software availability"));
C.push(body("Underlying data",{sz:22}));
C.push(body("All example data used in this manuscript are distributed with R or with the R packages used in the examples: mtcars and iris are included with base R, mpg is included with ggplot2, and lung is included with the survival package. No external datasets were used. The example code to reproduce all figures is included in the package vignette (vignette(\"multiplot\")) and as a standalone script at inst/examples/multiplot_demo.R in the source repository. After installing the package, users can locate and run the example script with source(system.file(\"examples\", \"multiplot_demo.R\", package = \"multiplot\"))."));
C.push(body("Extended data",{sz:22}));
C.push(body("Zenodo: multiplot — Software archive and extended data for manuscript submission. The v0.3.4 archive DOI is https://doi.org/10.5281/zenodo.21265224; the all-version concept DOI is https://doi.org/10.5281/zenodo.21137144. The Zenodo archive contains the following extended data files under the inst/paper/ directory: (1) table1_style_ontology.md — complete 10-style × 15-attribute ontology mapping across all five dimensions. (2) table2_compliance_assessment.md — full CVD safety, grayscale fidelity, and print-risk benchmark results. (3) compute_compliance_assessment.R and compliance_assessment_reproducibility.md — script and log used to reproduce Table 2. (4) verification_log.md — evidence tracking that distinguishes real screenshot checks, template screenshot checks, documentation-inferred settings, and the internally defined Academic benchmark. (5) session_info.txt — R session information used to generate the manuscript figures. Figure files are provided separately as PNG and PDF outputs generated by inst/examples/multiplot_demo.R. These files are also browsable directly from the GitHub repository. Extended data are available under the terms of the Creative Commons Attribution 4.0 International license (CC-BY 4.0)."));
C.push(body("Software availability",{sz:22}));
C.push(body("Software available from: https://github.com/sushuqiong/multiplot"));
C.push(body("Archived source code at time of publication: https://doi.org/10.5281/zenodo.21265224"));
C.push(body("License: MIT"));
C.push(body("The package can be installed in R via: remotes::install_github(\"sushuqiong/multiplot\")"));
C.push(BR());

// ---- AUTHOR CONTRIBUTIONS ----
C.push(H1("Author contributions"));
C.push(body("Shuqiong Su: Conceptualization, Software, Validation, Visualization, Writing – Original Draft, and Writing – Review & Editing. Shiyao Yang: Validation, Visualization, and Writing – Review & Editing. Guozhen Chen: Validation, Visualization, and Writing – Review & Editing. Aiqun Liu: Supervision, Funding Acquisition, Clinical/Application Framing, and Writing – Review & Editing."));
C.push(PL());

// ---- COMPETING INTERESTS ----
C.push(H1("Competing interests"));
C.push(body("No competing interests were disclosed. GraphPad Prism, SPSS, OriginPro, Stata, SigmaPlot, JMP, MATLAB, Minitab, and MedCalc are trademarks or product names of their respective owners. multiplot is not affiliated with, endorsed by, or sponsored by those owners.")); C.push(PL());

// ---- GRANT INFORMATION ----
C.push(H1("Grant information"));
C.push(body("This work was supported by grants from the Joint Project on Regional High-Incidence Diseases Research of the Guangxi Natural Science Foundation [grant number 2023GXNSFAA026298]; the Guangxi Medical and Health Key Cultivation Discipline Construction Project; and the Funding for the Development and Promotion of Suitable Medical and Health Technologies in Guangxi [grant number S2022107]. The funders had no role in the design of the software, style extraction, compliance assessment, manuscript preparation, or decision to submit the article for publication.")); C.push(PL());

// ---- ACKNOWLEDGMENTS ----
C.push(H1("Acknowledgments"));
C.push(body("We thank the developers of ggprism and r2spss for demonstrating the feasibility of single-software ggplot2 theme approximation and for providing useful reference implementations during development of the Prism- and SPSS-inspired styles. The MATLAB parula keypoints were derived from publicly available MathWorks documentation and reference values for the parula colour map."));
C.push(BR());

// ---- REFERENCES ----
C.push(H1("References"));
const refs = [
  "Peng RD. Reproducible research in computational science. Science. 2011; 334(6060): 1226–1227.",
  "Dawson C. ggprism: A ggplot2 Extension Inspired by GraphPad Prism. R package version 1.0.7. 2025. DOI: 10.32614/CRAN.package.ggprism.",
  "Alfons A. r2spss: Format R Output to Look Like SPSS. R package version 0.3.2. 2022. https://CRAN.R-project.org/package=r2spss.",
  "Arnold JB. ggthemes: Extra Themes, Scales and Geoms for ggplot2. R package version 5.1.0. 2024. https://CRAN.R-project.org/package=ggthemes.",
  "Wilke CO. cowplot: Streamlined Plot Theme and Plot Annotations for ggplot2. R package version 1.2.0. 2025. https://wilkelab.org/cowplot/.",
  "Weissgerber TL, Milic NM, Winham SJ, et al. Beyond bar and line graphs: time for a new data presentation paradigm. PLoS Biol. 2015; 13(4): e1002128.",
  "Birch J. Worldwide prevalence of red-green color deficiency. J Opt Soc Am A. 2012; 29(3): 313–320.",
  "Machado GM, Oliveira MM, Fernandes LAF. A physiologically-based model for simulation of color vision deficiency. IEEE Trans Vis Comput Graph. 2009; 15(6): 1291–1298.",
  "Zeileis A, Fisher JC, Hornik K, et al. colorspace: A toolbox for manipulating and assessing colors and palettes. J Stat Softw. 2020; 96(1): 1–49.",
  "Pedersen TL, Nicolae B, Francois R. farver: High performance colour space manipulation. R package version 2.1.2. 2024. https://CRAN.R-project.org/package=farver.",
  "Crameri F, Shephard GE, Heron PJ. The misuse of colour in science communication. Nat Commun. 2020; 11(1): 5444."
];
refs.forEach((r,i) => {
  C.push(new Paragraph({spacing:{after:60},indent:{left:360,hanging:360},
    children:[new TextRun({text:`${i+1}. `,font:"Arial",size:18,bold:true}),new TextRun({text:r,font:"Arial",size:18})]}));
});

// ---- BUILD ----
const outPath = "C:/Users/fengq/Desktop/开发R包multiplot/manuscript_of_multiplot_for_F1000Research_v0.3.4_draft.docx";
const previewPath = "C:/Users/fengq/Desktop/开发R包multiplot/manuscript_of_multiplot_for_F1000Research_v0.3.4_preview_with_figures.docx";

function makeDoc(children) {
  return new Document({
    styles:{default:{document:{run:{font:"Arial",size:22}}},
      paragraphStyles:[
        {id:"Heading1",name:"Heading 1",basedOn:"Normal",next:"Normal",quickFormat:true,run:{size:28,bold:true,font:"Arial"},paragraph:{spacing:{before:320,after:160},outlineLevel:0}},
        {id:"Heading2",name:"Heading 2",basedOn:"Normal",next:"Normal",quickFormat:true,run:{size:24,bold:true,font:"Arial"},paragraph:{spacing:{before:240,after:120},outlineLevel:1}}]},
    sections:[{properties:{page:{size:{width:12240,height:15840},margin:{top:1440,right:1440,bottom:1440,left:1800}}},
      headers:{default:new Header({children:[new Paragraph({alignment:AlignmentType.RIGHT,children:[new TextRun({text:"multiplot — F1000Research Software Tool Article",font:"Arial",size:16,italics:true,color:"888888"})]})]})},
      footers:{default:new Footer({children:[new Paragraph({alignment:AlignmentType.CENTER,children:[new TextRun({text:"Page ",font:"Arial",size:16,color:"888888"}),new TextRun({children:[PageNumber.CURRENT],font:"Arial",size:16,color:"888888"})]})]})},
      children}]});
}

const previewChildren = C.concat([BR(), H1("Embedded figure preview")]);
figurePreview.forEach(fig => {
  const png = `${FIGDIR}/Figure${fig.n}.png`;
  if (fs.existsSync(png)) {
    previewChildren.push(FIGCAP(fig.cap));
    previewChildren.push(imageParagraph(png, fig.w, fig.h));
  }
});

Packer.toBuffer(makeDoc(C)).then(buf=>{
  fs.writeFileSync(outPath,buf);
  console.log("Written: "+outPath+" ("+(buf.length/1024).toFixed(1)+" KB)");
  return Packer.toBuffer(makeDoc(previewChildren));
}).then(buf=>{
  fs.writeFileSync(previewPath,buf);
  console.log("Written: "+previewPath+" ("+(buf.length/1024).toFixed(1)+" KB)");
});
