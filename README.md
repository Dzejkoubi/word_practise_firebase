# English words practise

> Flutter aplikace na procvičování anglických slovíček z češtiny do angličtiny a nazpátek

## Jak hrát?

- Hráčovi se otevře obrazovka s tlačítkem play. Po stisknutí tlačítka se hráčovi objeví anglické nebo české slovo a pod ním textové pole na zadání správného předkladu.
- Zároveň pokud to slovo dovoluje tak má vedle napsanou nápovědu, kterou může odhalit.
- Hráč zadá slovo o kterém si myslí že je překladem zadaného slova
  - Pokud je slovo správně, přičte se mu bod
  - Pokud špatně odečte se mu bod
  - Pokud hráč neví může kliknout, po okrytí nápovědy, na tlačítko nevím a odečte se mu bod
- Pak se změní text překládaného slova a loop se opakuje
- Hra nemá konec jelikož minimální počet bodů je 0
- Hráč může ovšem překonávat své skóre

---

## Podrobnosti ke hraní

- Hráč si může nastavit zda překládat slova pouze z angličtiny do češtiny, naopak nebo obousměrně
  - Obousměrně - zadávané slovo může být jak v Češtině tak v Angličtině
- Přidávání vlastních slov
  - Hráč má na hlavní stránce možnost jít na stránku databáze jeho slov a přidat vlastní slovo
  - Teoreticky může hráč přidat do databáze jaké koliv slova

---

## Vysvětlení kódu

> I s tím co ještě není přidané

- **Základní verze hry**
  - JSON se slovy se musí konvertovat na Dart class “word-list” která v sobě má další calss-y “word-one” které obsahují slova a jejich překlady
    - JSON soubor má takovouhle strukturu
    ```json
    {
      "words": [
        {
          "czech": ["výběr", "odstoupení"],
          "english": ["withdrawal"],
          "hint": ["od smlouvy"]
        }
      ]
    }
    ```
    - Nebo je backend, tedy seznam slov, zajištěný na firebase-ce
      - Ještě nevím jak udělat
  - Jedno z class ze classy “word-list” se vybere a jedno ze slov se napíše do pole “quessed-word”
  - Hráč odpoví - klikne na tlačítko “odpovědět” nebo “enter” a to spustí funkci, která zkontroluje zda je to správně
    - Správně = přičte se jeden bod
    - Špatně = odečte se jeden bod
  - Pokud klidkne na nevím = odečte se jeden bod
  - Repeat
- **Přidávání vlastních slov**
  - Na hlavní stránce je v dolní liště tlačítko “Your words”
    - Když ho hráč rozklikne otevře se mu stránka “Your words”
  - Zde je za pomoci build list widgetu vygenerovaný seznam slov
  - Nahoře tím je tlačítko add word
    - Spustí funkce která otevře pole
      - Czech word
      - English word
      - Hint(nepovinné)
    - Do těchto polí zadá uživatel slova
    - Poté klikne na dolní tlačítko přidat a to překonvertuje celou dabase do json file a tím se slovo přidá
  - Pokud chce uživatel slovo odebrat tak je u slova ikona koše na tu když klikne tak se otevře popUp potvrzení
    - Pokud klikne na potvrdit tak se odebere slovo z classy a překonvertuje zase classu na json
  - Pak může kliknout uživatel na šipku zpět v levém horním rohu a to ho přenese na hlavní stránku

### Co přidat v budoucnu

- Login system
  - Firebase database
  - Uživatel má svoje slova v databázi
- Více databází/seznamů slov
