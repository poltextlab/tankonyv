# szovegbanyaszat_javitasok

(proba javtias)

Letolteni a github-rol a konyvet innen: https://github.com/aakosm/szovegbanyaszat_javitasok

A projektet az `szovegbanyaszat_javitasok.Rproj` fileal tudod megnyitni az RStudioban.

## RMarkdown segitsegek

A szamozott .Rmd fileok az egyes fejezetek, ezekben kell majd a javitasokat megcsinalni. Egy rovid Rmarkdown tutorialt itt talalsz: http://akosmate.com/intro_to_R_vms/08_rmarkdown/08_rmarkdown.html

Bovebb Rmarkdown dokumentacio: https://bookdown.org/yihui/rmarkdown-cookbook/

A konyv az R `bookdown` csomagjaval keszult, a teljes dokumentaciot itt talalod: https://bookdown.org/yihui/bookdown/ Ezt nyilvan nem kell elejetol a vegeig elolvasni, de sanszos hogy a felmerulo kerdesek egy jo reszere talalsz valaszt a fenti linkeken.


## A javitasok menete az RStudioban

1. Javitod a fejezetet a xx_blabla.Rmd fejezetben
2. Ellenorzod hogy mukodnek-e a javitasok:
   - A `_bookdown.yml` fileban az `rmd_files` felsorolasban csak az ellenorizendo fejezet ne legyen kikommentelve a `#` -el (az index.Rmd-t sose kell kikommentelni)
3. Lefuttatod `build_the_book.R` script egyetlen sorat
4. A `szovegbanyaszat_javitasok/docs/index.html` fileban tudod ellenorizni hogy sikerult-e megoldani a problemat.
5. Hogyha nem mukodik a javitas akkor addig nem tudod ujra futtatni a kodot amig nem torlod ki a `_main.Rmd` file-t.


## A github szinkron RStudioval
A githubra ugy tudod feltolteni a javitasokat, hogy az RStudio kis git ablakaban bepipalod a `staged` kis dobozokat, aztan pedig megnyomod a `commit` gombot. A felugro ablakban be kell irni valami `commit` uzenetet (ez barmi lehet, rovid de informativ legyen) es aztan `push`.


## Ha valami nem megy

Akkor kerdezz nyugodtan :)
