%let pgm=utl-meta-data-for-publish-quality-reports-with-different-title-footnotes-and-page-n-of-Nproc tabulate;var a b;table a(n)*f=5.*b(n)*f=5.;run;

Using meta data create multiple reports with different title footnotes and page n of N;

Pdf image of rtf file
https://tinyurl.com/2es74nd7
https://github.com/rogerjdeangelis/utl-meta-data-for-publish-quality-reports-with-different-title-footnotes-and-page-n-of-N/blob/main/difTytFot.pdf

rtf file
https://tinyurl.com/2smvmaew
https://github.com/rogerjdeangelis/utl-meta-data-for-publish-quality-reports-with-different-title-footnotes-and-page-n-of-N/blob/main/difTytFot.rtf

github
https://tinyurl.com/286x62bp
https://github.com/rogerjdeangelis/utl-meta-data-for-publish-quality-reports-with-different-title-footnotes-and-page-n-of-N


this message
https://goo.gl/ZZLhTv
https://communities.sas.com/t5/ODS-and-Base-Reporting/ODS-PDF-Write-a-line-of-text-if-condition-is-satisfied/m-p/348526


 1. pre-process
 2. problem
 3. input
 4. process
 5 output
 6 style macro utl_rtflan100
 7 report rpositories

/*
 _ __  _ __ ___   _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ | `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | |  __/ | |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___| | .__/|_|  \___/ \___\___||___/___/
|_|              |_|
*/

Creating a template can assure that all your reports have the same loook and feel.
You need call the rtf style macro on the end with post

  %utl_rtflan100
      (
        style          = utl_rtflan100
        ,outputwidth   = 100%
        ,frame         = box
        ,rules         = none
        ,TitleFont     = 11pt
        ,docfont       = 10pt
        ,fixedfont     = 9pt
        ,bottommargin  = .25in
        ,topmargin     = 1.5in
        ,rightmargin   = .75in
        ,leftmargin    = .75in
        ,cellheight    = 10pt
        ,cellpadding   = 5pt
        ,cellspacing   = 3pt
        ,borderwidth   = 1
      );

  You need to call this template using ods rtf

/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

/***************************************************************************************************************************************/
/*                                        |                                                       |                                    */
/*           INPUT                        |                    PROCESS                            |             OUTPUT                 */
/*                                        |                                                       |                                    */
/* WORK.META TOTAL OBS=2                  |  options nodate nonumber orientation=portrait;        |  FIRST PAGE                        */
/*                                        |  title;footnote;                                      |                                    */
/*                                        |  ods escapechar='^';                                  |  Student Clinical Trial Males      */
/*  Obs   PAT1        TYT1 (TITLES)       |  ods listing close;                                   |  Invoice 2378675 Rural Patients    */
/*    (subset)                            |  ods rtf file="&outfile" style=utl_rtflan100          |                                    */
/*   1    M  Invoice 2378 Rural Patients  |   notoc_data;                                         |  NAME   SEX AGE HEIGHT  WEIGHT     */
/*   2    F  Invoice 288 Urban Patients   |  %symdel pge pat tyt fot/ nowarn;                     |          M   14   69    112.5      */
/*                                        |  data _null_;                                         |  Alfred  M   14   63.5  102.5      */
/*                   FOT1 (FOOTNOTES)     |                                                       |  Henry   M   12   57.3   83        */
/*                                        |   * get meta data;                                    |  James   M   13   62.5   84        */
/*   1   see Protocol 1013.6(Oncology)    |   if _n_=0 then do;                                   |  Jeffrey M   12   59     99.5      */
/*   2   see Protocol 10883.6(Analgesics) |     rc=%sysfunc(dosubl('                              |  John    M   16   72    150        */
/*                                        |       proc sql noprint ;                              |  Philip  M   12   64.8  128        */
/*                                        |        select                                         |  Robert  M   15   67    133        */
/* SASHELP.CLASSFIT TOTAL OBS=19          |           quote(pat1)                                 |  Ronald  M   11   57.5   85        */
/*                                        |          ,quote(tyt1)                                 |  Thomas  M   15   66.5  112        */
/* Obs  NAME    SEX AGE HEIGHT WEIGHT     |          ,quote(fot1)                                 |                                    */
/*                                        |           into                                        |  Program: c:/utl/dm.sas_09APR17    */
/*   1  Alfred   M   14  69.0   112.5     |             :pat separated by ","                     |  Log: c:/utl/dm.log_09APR17        */
/*   2  Alice    F   13  56.5    84.0     |            ,:tyt separated by ","                     |  see Protocol 1013.6(Oncology)     */
/*   3  Barbara  F   13  65.3    98.0     |            ,:fot separated by ","                     |                      Page 1 of 2   */
/*   4  Carol    F   14  62.8   102.5     |           from                                        |                                    */
/*   5  Henry    M   14  63.5   102.5     |             meta                                      |                                    */
/*   6  James    M   12  57.3    83.0     |          ;quit;                                       |  SECOND PAGE                       */
/*  ...                                   |          '));                                         |                                    */
/*                                        |           end;                                        |  Student Clinical Trial Females    */
/*                                        |                                                       |  Invoice 288675  Urban Patients    */
/*  %utl_rtflan100                        |   array pat[&sqlobs] $8  (&pat.);                     |                                    */
/*    (                                   |   array tyt[&sqlobs] $64 (&tyt.);                     |  NAME    SEX AGE HEIGHT  WEIGHT    */
/*      style          = utl_rtflan100    |   array fot[&sqlobs] $64 (&fot.);                     |           F   14   69    112.5     */
/*      ,outputwidth   = 100%             |                                                       |  Alice    F   14   63.5  102.5     */
/*      ,frame         = box              |   do i=1 to &sqlobs;                                  |  Barbara  F   12   57.3   83       */
/*      ,rules         = none             |                                                       |  Carol    F   13   62.5   84       */
/*      ,TitleFont     = 11pt             |    call symputx('pat',pat[i]);                        |  Jane     F   12   59     99.5     */
/*      ,docfont       = 10pt             |    call symputx('tyt',tyt[i]);                        |  Janet    F   16   72    150       */
/*      ,fixedfont     = 9pt              |    call symputx('fot',fot[i]);                        |  Joyce    F   12   64.8  128       */
/*      ,bottommargin  = .25in            |    call symputx('pge',put(i,1.));                     |  Judy     F   15   67    133       */
/*      ,topmargin     = 1.5in            |                                                       |  Louise   F   11   57.5   85       */
/*      ,rightmargin   = .75in            |    rc=dosubl('                                        |  Mary     F   15   66.5  112       */
/*      ,leftmargin    = .75in            |      ods rtf prepage=                                 |                                    */
/*      ,cellheight    = 10pt             |        %sysfunc(compbl("^S={outputwidth=100% just=c   |  Program: c:/utl/dm.sas_09APR17    */
/*      ,cellpadding   = 5pt              |            font_size=11pt                             |  Log: c:/utl/dm.log_09APR17        */
/*      ,cellspacing   = 3pt              |            font_face=arial}                           |  see Protocol 10883.6(Analgesics)  */
/*      ,borderwidth   = 1                |            {Student Clinical Trial Gender=&pat.}      |                       Page 2 of 2  */
/*    );                                  |           ^{newline}{&tyt}"));                        |                                    */
/*                                        |      proc report data=sashelp.classfit                |                                    */
/*                                        |         (drop=lowermean uppermean                     |                                    */
/*                                        |         where=(sex="&pat"))  style(column)=           |                                    */
/*                                        |          {just=right}  style(header)={just=right}     |                                    */
/*                                        |          nowd split="#" missing;                      |                                    */
/*                                        |      format  _numeric_ 6.1 age 2.;                    |                                    */
/*                                        |      label name = "Name" sex="Sex" age="Age"          |                                    */
/*                                        |            height="Height" weight="Weight";           |                                    */
/*                                        |      run;quit;                                        |                                    */
/*                                        |      ods rtf text="^S={outputwidth=100% just=r        |                                    */
/*                                        |        font_size=9pt}^{newline} Page &pge of &sqlobs";|                                    */
/*                                        |      ods rtf text="^S={outputwidth=100% just=l        |                                    */
/*                                        |        font_size=8pt font_style=italic                |                                    */
/*                                        |        } {Program: c:/utl/dm.sas_&sysdate}";          |                                    */
/*                                        |      ods rtf text="^S={outputwidth=100% just=l        |                                    */
/*                                        |        font_size=8pt font_style=italic                |                                    */
/*                                        |        } {Log: c:/utl/dm.log_&sysdate}^{newline}";    |                                    */
/*                                        |      ods rtf text="^S={outputwidth=100% just=l        |                                    */
/*                                        |        font_size=8pt font_style=italic} {&fot}";      |                                    */
/*                                        |    ');                                                |                                    */
/*                                        |   end;                                                |                                    */
/*                                        |   stop;                                               |                                    */
/*                                        |  run;quit;                                            |                                    */
/*                                        |  ods rtf close;                                       |                                    */
/*                                        |  ods listing;                                         |                                    */
/*                                        |                                                       |                                    */
/***************************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/


data meta;
  pge1='1';
  pat1='M';
  tyt1='Invoice 2378675 for Rural Partipicpants ';
  fot1='see Protocol 1013.6(Oncology)           ';
  output;
  pge1='2';
  pat1='F';
  tyt1='Invoice 288675 for Urban Partipicpants  ';
  fot1='see Protocol 10883.6(Analgesics)        ';
  output;
run;quit;

%utl_rtflan100
    (
      style          = utl_rtflan100
      ,outputwidth   = 100%
      ,frame         = box
      ,rules         = none
      ,TitleFont     = 11pt
      ,docfont       = 10pt
      ,fixedfont     = 9pt
      ,bottommargin  = .25in
      ,topmargin     = 1.5in
      ,rightmargin   = .75in
      ,leftmargin    = .75in
      ,cellheight    = 10pt
      ,cellpadding   = 5pt
      ,cellspacing   = 3pt
      ,borderwidth   = 1
    );

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/

options nodate nonumber orientation=portrait;
title;footnote;
ods escapechar='^';
ods listing close;
ods rtf file="&outfile" style=utl_rtflan100
 notoc_data;
%symdel pge pat tyt fot/ nowarn;
data _null_;

 * get meta data;
 if _n_=0 then do;
   rc=%sysfunc(dosubl('
     proc sql noprint ;
      select
         quote(pat1)
        ,quote(tyt1)
        ,quote(fot1)
         into
           :pat separated by ","
          ,:tyt separated by ","
          ,:fot separated by ","
         from
           meta
        ;quit;
        '));
         end;

 array pat[&sqlobs] $8  (&pat.);
 array tyt[&sqlobs] $64 (&tyt.);
 array fot[&sqlobs] $64 (&fot.);

 do i=1 to &sqlobs;

  call symputx('pat',pat[i]);
  call symputx('tyt',tyt[i]);
  call symputx('fot',fot[i]);
  call symputx('pge',put(i,1.));

  rc=dosubl('
    ods rtf prepage=
      %sysfunc(compbl("^S={outputwidth=100% just=c
          font_size=11pt
          font_face=arial}
          {Student Clinical Trial Gender=&pat.}
         ^{newline}{&tyt}"));
    proc report data=sashelp.classfit
       (drop=lowermean uppermean
       where=(sex="&pat"))  style(column)=
        {just=right}  style(header)={just=right}
        nowd split="#" missing;
    format  _numeric_ 6.1 age 2.;
    label name = "Name" sex="Sex" age="Age"
          height="Height" weight="Weight";
    run;quit;
    ods rtf text="^S={outputwidth=100% just=r
      font_size=9pt}^{newline} Page &pge of &sqlobs"
    ods rtf text="^S={outputwidth=100% just=l
      font_size=8pt font_style=italic
      } {Program: c:/utl/dm.sas_&sysdate}";
    ods rtf text="^S={outputwidth=100% just=l
      font_size=8pt font_style=italic
      } {Log: c:/utl/dm.log_&sysdate}^{newline}";
    ods rtf text="^S={outputwidth=100% just=l
      font_size=8pt font_style=italic} {&fot}";
  ');
 end;
 stop;
run;quit;
ods rtf close;
ods listing;

/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/

/**************************************************************************************************************************/
/*                                                                                                                        */
/* PAGE 1                                                                                                                 */
/*                                                                                                                        */
/* Student Clinical Trial Males                                                                                           */
/* Invoice 2378675 for Rural Partipicpants                                                                                */
/*                                                                                                                        */
/* NAME      SEX      AGE   HEIGHT      WEIGHT                                                                            */
/*                                                                                                                        */
/* Alfred      M      14      69        112.5                                                                             */
/* Henry       M      14      63.5      102.5                                                                             */
/* James       M      12      57.3       83                                                                               */
/* Jeffrey     M      13      62.5       84                                                                               */
/* John        M      12      59         99.5                                                                             */
/* Philip      M      16      72        150                                                                               */
/* Robert      M      12      64.8      128                                                                               */
/* Ronald      M      15      67        133                                                                               */
/* Thomas      M      11      57.5       85                                                                               */
/* William     M      15      66.5      112                                                                               */
/*                                                                                                                        */
/* Program: c:/utl/dm.sas_09APR17                                                                                         */
/* Log: c:/utl/dm.log_09APR17                                                                                             */
/* see Protocol 1013.6(Oncology)    Page 1 of 2                                                                           */
/*                                                                                                                        */
/*                                                                                                                        */
/* PAGE 2                                                                                                                 */
/*                                                                                                                        */
/*  Student Clinical Trial Females                                                                                        */
/* Invoice 288675 for Urban Partipicpants                                                                                 */
/*                                                                                                                        */
/* NAME      SEX      AGE   HEIGHT      WEIGHT                                                                            */
/*                                                                                                                        */
/* Alice      F      13      56.5       84                                                                                */
/* Barbara    F      13      65.3       98                                                                                */
/* Carol      F      14      62.8      102.5                                                                              */
/* Jane       F      12      59.8       84.5                                                                              */
/* Janet      F      15      62.5      112.5                                                                              */
/* Joyce      F      11      51.3       50.5                                                                              */
/* Judy       F      14      64.3       90                                                                                */
/* Louise     F      12      56.3       77                                                                                */
/* Mary       F      15      66.5      112                                                                                */
/*                                                                                                                        */
/* Program: c:/utl/dm.sas_09APR17                                                                                         */
/* Log: c:/utl/dm.log_09APR17                                                                                             */
/* see Protocol 10883.6(Analgesics) Page 2 of 2                                                                           */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*   _         _             _   _          _    __ _             _  ___   ___
 ___| |_ _   _| | ___  _   _| |_| |    _ __| |_ / _| | __ _ _ __ / |/ _ \ / _ \
/ __| __| | | | |/ _ \| | | | __| |   | `__| __| |_| |/ _` | `_ \| | | | | | | |
\__ \ |_| |_| | |  __/| |_| | |_| |   | |  | |_|  _| | (_| | | | | | |_| | |_| |
|___/\__|\__, |_|\___| \__,_|\__|_|___|_|   \__|_| |_|\__,_|_| |_|_|\___/ \___/
         |___/                   |_____|
*/

Macro utl_rtflan100
    (
      style=utl_rtflan100
      ,outputwidth=100%
      ,frame=box
      ,TitleFont=11pt
      ,docfont=10pt
      ,fixedfont=9pt
      ,rules=none
      ,bottommargin=.25in
      ,topmargin=1.5in
      ,rightmargin=1.0in
      ,leftmargin=.75in
      ,cellheight=13pt
      ,cellpadding = 7pt
      ,cellspacing = 3pt
      ,borderwidth = 1
    ) /  Des="SAS PDF Template for PDF";

ods path work.templat(update) sasuser.templat(update) sashelp.tmplmst(read);

Proc Template;

   define style &Style;
   parent=styles.rtf;

        replace body from Document /

               protectspecialchars=off
               asis=on
               bottommargin=&bottommargin
               topmargin   =&topmargin
               rightmargin =&rightmargin
               leftmargin  =&leftmargin
               ;

        replace color_list /
              'link' = blue
               'bgH'  = _undef_
               'fg'  = black
               'bg'   = _undef_;

        replace fonts /
               'TitleFont2'           = ("Arial, Helvetica, Helv",&titlefont,Bold)
               'TitleFont'            = ("Arial, Helvetica, Helv",&titlefont,Bold)

               'HeadingFont'          = ("Arial, Helvetica, Helv",&titlefont)
               'HeadingEmphasisFont'  = ("Arial, Helvetica, Helv",&titlefont,Italic)

               'StrongFont'           = ("Arial, Helvetica, Helv",&titlefont,Bold)
               'EmphasisFont'         = ("Arial, Helvetica, Helv",&titlefont,Italic)

               'FixedFont'            = ("Courier New, Courier",&fixedfont)
               'FixedEmphasisFont'    = ("Courier New, Courier",&fixedfont,Italic)
               'FixedStrongFont'      = ("Courier New, Courier",&fixedfont,Bold)
               'FixedHeadingFont'     = ("Courier New, Courier",&fixedfont,Bold)
               'BatchFixedFont'       = ("Courier New, Courier",&fixedfont)

               'docFont'              = ("Arial, Helvetica, Helv",&docfont)

               'FootFont'             = ("Arial, Helvetica, Helv", 9pt)
               'StrongFootFont'       = ("Arial, Helvetica, Helv",8pt,Bold)
               'EmphasisFootFont'     = ("Arial, Helvetica, Helv",8pt,Italic)
               'FixedFootFont'        = ("Courier New, Courier",8pt)
               'FixedEmphasisFootFont'= ("Courier New, Courier",8pt,Italic)
               'FixedStrongFootFont'  = ("Courier New, Courier",7pt,Bold);

        style Graph from Output/
                outputwidth = 100% ;

        style table from table /
                outputwidth=&outputwidth
                protectspecialchars=off
                asis=on
                background = colors('tablebg')
                frame=&frame
                rules=&rules
                cellheight  = &cellheight
                cellpadding = &cellpadding
                cellspacing = &cellspacing
                bordercolor = colors('tableborder')
                borderwidth = &borderwidth;

         replace Footer from HeadersAndFooters

                / font = fonts('FootFont')  just=left asis=on protectspecialchars=off ;

                replace FooterFixed from Footer
                / font = fonts('FixedFootFont')  just=left asis=on protectspecialchars=off;

                replace FooterEmpty from Footer
                / font = fonts('FootFont')  just=left asis=on protectspecialchars=off;

                replace FooterEmphasis from Footer
                / font = fonts('EmphasisFootFont')  just=left asis=on protectspecialchars=off;

                replace FooterEmphasisFixed from FooterEmphasis
                / font = fonts('FixedEmphasisFootFont')  just=left asis=on protectspecialchars=off;

                replace FooterStrong from Footer
                / font = fonts('StrongFootFont')  just=left asis=on protectspecialchars=off;

                replace FooterStrongFixed from FooterStrong
                / font = fonts('FixedStrongFootFont')  just=left asis=on protectspecialchars=off;

                replace RowFooter from Footer
                / font = fonts('FootFont')  asis=on protectspecialchars=off just=left;

                replace RowFooterFixed from RowFooter
                / font = fonts('FixedFootFont')  just=left asis=on protectspecialchars=off;

                replace RowFooterEmpty from RowFooter
                / font = fonts('FootFont')  just=left asis=on protectspecialchars=off;

                replace RowFooterEmphasis from RowFooter
                / font = fonts('EmphasisFootFont')  just=left asis=on protectspecialchars=off;

                replace RowFooterEmphasisFixed from RowFooterEmphasis
                / font = fonts('FixedEmphasisFootFont')  just=left asis=on protectspecialchars=off;

                replace RowFooterStrong from RowFooter
                / font = fonts('StrongFootFont')  just=left asis=on protectspecialchars=off;

                replace RowFooterStrongFixed from RowFooterStrong
                / font = fonts('FixedStrongFootFont')  just=left asis=on protectspecialchars=off;

                replace SystemFooter from TitlesAndFooters / asis=on
                        protectspecialchars=off just=left;
    end;
run;
quit;

%Mend utl_rtflan100;

/*                         _
 _ __ ___ _ __   ___  _ __| |_   _ __ ___ _ __   ___  ___
| `__/ _ \ `_ \ / _ \| `__| __| | `__/ _ \ `_ \ / _ \/ __|
| | |  __/ |_) | (_) | |  | |_  | | |  __/ |_) | (_) \__ \
|_|  \___| .__/ \___/|_|   \__| |_|  \___| .__/ \___/|___/
         |_|                             |_|
*/

Select report from d:/git/git_010_repos.sasbdat

REPO
------------------------------------------------------------------------------------------------------------------------------
https://github.com/rogerjdeangelis/utl-Changing-variable-labels-formats-and-informats-with-proc-sort-transpose-report-and-mean
https://github.com/rogerjdeangelis/utl-Compendium-of-proc-report-clinical-tables
https://github.com/rogerjdeangelis/utl-adding-categories-that-are-NOT-in-your-data-to-proc-report-and--proc-tabulate
https://github.com/rogerjdeangelis/utl-allign-parentheses-decimal-points-in-proc-report
https://github.com/rogerjdeangelis/utl-amazing-proc-report-output-table-with-count-distinct-and-other-statistics-by-group
https://github.com/rogerjdeangelis/utl-array-and-do-over-macros-to-generate-define-statements-of-proc-report
https://github.com/rogerjdeangelis/utl-collapsing-nested-headers-in-proc-report-with-output-sas-dataset
https://github.com/rogerjdeangelis/utl-complex-proc-tabulate-in-proc-report-with-output-table-that-is-an-image-of-tabulate
https://github.com/rogerjdeangelis/utl-compute-column-in-proc-report-works-like-the-datastep
https://github.com/rogerjdeangelis/utl-cost-report-analysis
https://github.com/rogerjdeangelis/utl-create-a-dataset-of-counts-and-percent-differences-with-just-proc-report
https://github.com/rogerjdeangelis/utl-creating-a-clinical-demographic-report-using-r-and-python-sql
https://github.com/rogerjdeangelis/utl-creating-a-crosstab-dataset-with-a-zero-row-using-proc-report-preloadfmt
https://github.com/rogerjdeangelis/utl-creating-a-two-by-two-grid-of-reports-in-excel
https://github.com/rogerjdeangelis/utl-creating-and-output-dataset-from-proc-report-with-meaningful-names
https://github.com/rogerjdeangelis/utl-creating-ods-output-table-from-proc-report-experimental
https://github.com/rogerjdeangelis/utl-crosstab-output-tables-from-corresp-report-not-static-tabulate
https://github.com/rogerjdeangelis/utl-detail-proc-freq-crosstab-ods-output-table-instead-of-static-reports
https://github.com/rogerjdeangelis/utl-do-not-program-mutiple-complex-proc-report-compute-blocks
https://github.com/rogerjdeangelis/utl-dosubl-using-meta-data-with-column-names-and-labels-to-create-mutiple-proc-reports
https://github.com/rogerjdeangelis/utl-embed-sql-code-inside-proc-report-using-dosubl
https://github.com/rogerjdeangelis/utl-example-of-ods-crosstab-output-table-with-mean-and-std-using_proc-report
https://github.com/rogerjdeangelis/utl-excel-changing-cell-contents-inside-proc-report
https://github.com/rogerjdeangelis/utl-excel-grid-of-four-reports-in-one-sheet
https://github.com/rogerjdeangelis/utl-excel-report-with-two-side-by-side-graphs-below_python
https://github.com/rogerjdeangelis/utl-excel-using-proc-report-workarea-columns-to-operate--on-arbitrary-row
https://github.com/rogerjdeangelis/utl-fixing-bugs-in-proc-report-tabulate-and-freq-output-crosstab-datasets
https://github.com/rogerjdeangelis/utl-formatting-aggregated-across-cells-as-character-in-proc-report-not-possible-in-tabulate
https://github.com/rogerjdeangelis/utl-is-proc-report-more-flexible-than-proc-summary-or-tabulate-when-an-output-dataset-is-needed
https://github.com/rogerjdeangelis/utl-is-proc-report-more-powerfull-than-proc-summary-or-proc-means
https://github.com/rogerjdeangelis/utl-layout-ods-excel-reports-in-a-grid
https://github.com/rogerjdeangelis/utl-minimum-code-for-a-very-simple-n-percent-crosstab-proc-report
https://github.com/rogerjdeangelis/utl-nice-collection-of-FDA-submission-reports
https://github.com/rogerjdeangelis/utl-nice-example-of-alias-columns-in-wps-proc-report
https://github.com/rogerjdeangelis/utl-proc-report-adding-additional-arbitrary-summary-rows
https://github.com/rogerjdeangelis/utl-proc-report-calculate-sub-totals-and-add-serial-no-with-the-sorted-group-variable
https://github.com/rogerjdeangelis/utl-proc-report-compute-after-grouped-summarizations-not-easy
https://github.com/rogerjdeangelis/utl-proc-report-compute-with-multiple-across-variables
https://github.com/rogerjdeangelis/utl-proc-report-greenbar-or-alternate-shading-of-rows-for-easy-reading
https://github.com/rogerjdeangelis/utl-retaining-header-row-across-pages-on-ods-rtf-proc-report
https://github.com/rogerjdeangelis/utl-side-by-side-proc-report-output-in-pdf-html-and-excel
https://github.com/rogerjdeangelis/utl-side-by-side-reports-within-arbitrary-positions-in-one-excel-sheet-wps-r
https://github.com/rogerjdeangelis/utl-simple-proc-report-and-tabulate-n-and-percent-crosstab-ourput-datasets-
https://github.com/rogerjdeangelis/utl-skilled-nursing-cost-reports-2011-2019-in-excel
https://github.com/rogerjdeangelis/utl-the-all-powerfull-proc-report-to-create-transposed-sorted-and-summarized-output-datasets
https://github.com/rogerjdeangelis/utl-three-dimensional-crosstab-proc-freq-tabulate-corresp-and-report
https://github.com/rogerjdeangelis/utl-transpose-macro-rather-than-proc-print-report-or-tabulate
https://github.com/rogerjdeangelis/utl-transposing-multiple-variables-using-transpose-macro-sql-arrays-proc-report
https://github.com/rogerjdeangelis/utl-transposing-mutiple-variables-using-a-specific-format-proc-report
https://github.com/rogerjdeangelis/utl-transposing-sorting-and-summarizing-with-a-single-proc-corresp-freq-tabulate-and-report
https://github.com/rogerjdeangelis/utl-use-dosubl-to-save-your-format-code-inside-proc-report
https://github.com/rogerjdeangelis/utl-use-proc-report-instead-of-tabulate-most-of-the-time
https://github.com/rogerjdeangelis/utl-use-report-instead-of-tabulate-and-get-the-bonus-of-an-output-table
https://github.com/rogerjdeangelis/utl-use-the-proc-report-list-option-to-understand-what-proc-report-is-doing
https://github.com/rogerjdeangelis/utl-using-proc-report-output-dataset-to-touch-up-a-report
https://github.com/rogerjdeangelis/utl-workaround-for--proc-report-bug-when-highlighting-individual-cells-in-an-across-variable
https://github.com/rogerjdeangelis/utl_another_N_Percent_report_crosstab
https://github.com/rogerjdeangelis/utl_clinical_report
https://github.com/rogerjdeangelis/utl_compare_corresp_vs_report_output_datasets
https://github.com/rogerjdeangelis/utl_eliminating_gaps_between_records_in_proc_report
https://github.com/rogerjdeangelis/utl_extreme_document_styling_in_four_reporting_formats
https://github.com/rogerjdeangelis/utl_flexible_complex_multi-dimensional_transpose_using_one_proc_report
https://github.com/rogerjdeangelis/utl_flexible_proc_report
https://github.com/rogerjdeangelis/utl_gather_macro_and_proc_report_for_quick_crosstabs_with_meaningful_names
https://github.com/rogerjdeangelis/utl_minimal_code_for_demographic_clinical_n_percent_report
https://github.com/rogerjdeangelis/utl_minimum_code_for_a_complex_proc_report
https://github.com/rogerjdeangelis/utl_minimum_code_npct_clinical_report_with_bigN_headers
https://github.com/rogerjdeangelis/utl_nice_reports_using_put_all_with_various_formats
https://github.com/rogerjdeangelis/utl_ods_excel_font_size_and_justification_proc_report_titles_formatting
https://github.com/rogerjdeangelis/utl_proc_report_add_total_of_amount_in_the_header
https://github.com/rogerjdeangelis/utl_proc_report_creating_three_dimensional_output
https://github.com/rogerjdeangelis/utl_proc_report_different_titles_headers_footnotes_and_number_of_obs_per_page
https://github.com/rogerjdeangelis/utl_proc_report_move_group_label_to_last_line_of_group
https://github.com/rogerjdeangelis/utl_proc_report_page_x_of_y_by_group
https://github.com/rogerjdeangelis/utl_proc_report_useful_tips_counters_conditional_rows_templates
https://github.com/rogerjdeangelis/utl_proc_report_with_different_margins_on_even_and_odd_pages
https://github.com/rogerjdeangelis/utl_recovering_after_you_have_painted_yourself_in_a_corner_with_proc_report
https://github.com/rogerjdeangelis/utl_report_does_not_show_group_variable_across_new_pages_in_rtf_and_pdf
https://github.com/rogerjdeangelis/utl_report_on_duplicated_combinations_of_subject_id_and_other_unique_ids
https://github.com/rogerjdeangelis/utl_resizing_an_image_in_report_writing_interface
https://github.com/rogerjdeangelis/utl_side_by_side_excel_reports
https://github.com/rogerjdeangelis/utl_sort_transpose_and_summarize_a_dataset_using_just_one_proc_report
https://github.com/rogerjdeangelis/utl_tabulate_or_report_spanning_lines
https://github.com/rogerjdeangelis/utl_transpose_with_proc_report

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
