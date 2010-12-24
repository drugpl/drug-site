snippet = ContentBlocks::Models::Snippet[:about_us]
snippet.content = <<EOS
Dolnośląska Grupa Użytkowników Ruby to cykliczne spotkania pasjonatów tego języka programowania. Każde spotkanie jest doskonałą okazją wymiany doświadczeń oraz poznania ludzi, na co dzień zajmujacych się tą technologią.

Spotkania mają charakter otwartego panelu dyskusyjnego - uczestnicy włączaja sie w udział w trakcie przygotowanych prelekcji. Zapraszamy zarówno tych zaawansowanych jak i stawiających pierwsze kroki w środowisku Rubiego!
EOS
snippet.save!
snippet.draft? && publish!

snippet = ContentBlocks::Models::Snippet[:community]
snippet.content = <<EOS
"Forum Ruby On Rails":http://rubyonrails.pl/forum
"Rubysfera":http://www.rubysfera.pl
"pl.comp.os.lang.ruby":http://groups.google.com/group/pl.comp.lang.ruby
"WRUG":http://www.wrug.eu
"KRUG":http://www.ruby.org.pl
"SRUG":http://srug.pl
"TRUG":http://trug.pl
"LRUG":http://lrug.pl
EOS
snippet.save!
snippet.draft? && publish!

snippet = ContentBlocks::Models::Snippet[:online]
snippet.content = <<EOS
"Lista dyskusyjna":http://librelist.org/browser/drug.rb
"Twitter":http://twitter.com/#!/drug_rb
"Github":http://www.github.com/drug-rb
EOS
snippet.save!
snippet.draft? && publish!
