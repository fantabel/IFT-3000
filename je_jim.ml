(***************************************************************************) 
(* Jeu d'essai - TP2 - ÉTÉ 2014                                            *) 
(***************************************************************************)

(* Pour changer ou obtenir le répertoire courant
Sys.getcwd ();;
Sys.chdir;; 
*)

(* Pour afficher les listes avec plus de «profondeurs»:
#print_depth 1000;;
#print_length 1000;;
*)

(* On charge le fichier ml du Tp après avoir implanté 
les méthodes demandées pour realiser les tests  *)
print_string "\nChargement du fichier TP2-E2014.ml";;
#use "TP2-E2014.ml";;

(* Résultat:
module type TP2E14 =
  sig
    type fait = string
    class regle :
      fait list ->
      fait list ->
      bool ->
      object
        val conclusions : fait list
        val premisses : fait list
        val mutable utilisee : bool
        method get_conclusions : fait list
        method get_premisses : fait list
        method get_utilisee : bool
        method set_utilisee : bool -> unit
      end
    class sexpert :
      string ->
      object val sorte_sexpert : string method get_sorte_sexpert : string end
    class sexpert_taxonomique :
      string ->
      string ->
      object
        val mutable base_faits : fait list
        val mutable base_regles : regle list
        val nom_sexpert : string
        val sorte_sexpert : string
        method afficher_sexpert : unit
        method ajouter_fait : fait -> unit
        method ajouter_liste_faits : fait list -> unit
        method ajouter_liste_regles : (fait list * fait list) list -> unit
        method ajouter_regle : regle -> unit
        method chainage_arriere : fait -> bool
        method chainage_avant : int
        method fait_existe : fait -> bool
        method get_base_faits : fait list
        method get_base_regles : regle list
        method get_nom_sexpert : string
        method get_sorte_sexpert : string
        method initialiser_utilisee_regles : unit
        method regle_existe : regle -> bool
        method set_base_faits : fait list -> unit
        method set_base_regles : regle list -> unit
        method supprimer_fait : fait -> unit
        method supprimer_regle : regle -> unit
        method vider_base_faits : unit
        method vider_base_regles : unit
      end
  end
module Tp2e14 : TP2E14
*)

(* On ouvre le module disposant de fonctions pertinentes pour nos tests *) 
open Tp2e14;;

(* On exécute maintenant les méthodes une à une *)

print_string "\nCreation du systeme expert taxonomique.";;
let se = new sexpert_taxonomique "Système expert taxonomique" "Classer des espèces animales";;

(* Résultat:
Nouveau Système expert taxonomique: Classer des espèces animales
val se : Tp2e14.sexpert_taxonomique = <obj>
*)

print_string "\nCreation d'une regle";;
let r1 = new regle ["a des poils"] ["est un mammifère"] false;;

(* Résultat:
val r1 : Tp2e14.regle = <obj>
*)

print_string "\nAjout de la regle au systeme expert";;
se#ajouter_regle r1;;

(* Résultat:
- : unit = ()
*)

print_string "\nAffichage du systeme expert";;
se#afficher_sexpert;;

(* Résultat:
Base des règles:
Règle numéro 1: 
 Prémisses: a des poils
 Conclusions: est un mammifère
utilisee = false
Base des faits:
Liste vide
- : unit = ()
*)

print_string "\nAjout une liste de regles au systeme expert";;
se#ajouter_liste_regles
    [(["nourrit ses petits au lait"], ["est un mammifère"]);
     (["a des plumes"],["est un oiseau"]);
     (["vole";"pond des oeufs"], ["est un oiseau"]);
     (["est un mammifère";"mange de la viande"],["est un carnivore"]);
     (["est un mammifère";"a les yeux dirigés en avant";"a des dents pointues";"a des griffes"],["est un carnivore"]);
     ["est un mammifère";"a des ongles"],["est un ongulé"];
     (["est un carnivore";"est brun";"a des taches noires"],["est un guépard"]);
     (["est un carnivore";"est brun";"a des raies noires"],["est un tigre"]);
     (["est un ongulé";"a un long cou";"est brun";"a des taches noires"],["est une girafe"]);
     (["est un ongulé";"est blanc";"a des raies noires"],["est un zèbre"]);
     (["est un oiseau";"ne vole pas"],["est un oiseau non volant"]);
     (["est un oiseau";"nage"],["est un oiseau non volant"]);
     (["est un oiseau non volant";"a des pattes longues";"a un long cou";"est noir et blanc"],["est une autruche"]);
     (["est un oiseau non volant";"a des pattes palmées";"est noir et blanc"],["est un pingouin"]);
     (["est un oiseau";"vole remarquablement"],["est un albatros"])];;

(* Résultat:
- : unit = ()
*)

print_string "\nVerification de la presence de la premiere regle ajoute au Systeme";;
se#regle_existe r1;;

(* Résultat:
- : bool = true
*)

print_string "\nAjoute un fait au systeme expert";;
se#ajouter_fait "a des poils";;
(* Résultat:
- : unit = ()
*)
print_string "\nAjouter une liste de fait au systeme expert";;
se#ajouter_liste_faits ["a des ongles";"a un long cou";"est brun";"a des taches noires"];;

(* Résultat:
- : unit = ()
*)

print_string "\nAfficher le systeme expert";;
se#afficher_sexpert;;

(* Résultat:
Base des règles:
Règle numéro 1: 
 Prémisses: a des poils
 Conclusions: est un mammifère
utilisee = false
Règle numéro 2: 
 Prémisses: nourrit ses petits au lait
 Conclusions: est un mammifère
utilisee = false
Règle numéro 3: 
 Prémisses: a des plumes
 Conclusions: est un oiseau
utilisee = false
Règle numéro 4: 
 Prémisses: vole; pond des oeufs
 Conclusions: est un oiseau
utilisee = false
Règle numéro 5: 
 Prémisses: est un mammifère; mange de la viande
 Conclusions: est un carnivore
utilisee = false
Règle numéro 6: 
 Prémisses: est un mammifère; a les yeux dirigés en avant; a des dents pointues; a des griffes
 Conclusions: est un carnivore
utilisee = false
Règle numéro 7: 
 Prémisses: est un mammifère; a des ongles
 Conclusions: est un ongulé
utilisee = false
Règle numéro 8: 
 Prémisses: est un carnivore; est brun; a des taches noires
 Conclusions: est un guépard
utilisee = false
Règle numéro 9: 
 Prémisses: est un carnivore; est brun; a des raies noires
 Conclusions: est un tigre
utilisee = false
Règle numéro 10: 
 Prémisses: est un ongulé; a un long cou; est brun; a des taches noires
 Conclusions: est une girafe
utilisee = false
Règle numéro 11: 
 Prémisses: est un ongulé; est blanc; a des raies noires
 Conclusions: est un zèbre
utilisee = false
Règle numéro 12: 
 Prémisses: est un oiseau; ne vole pas
 Conclusions: est un oiseau non volant
utilisee = false
Règle numéro 13: 
 Prémisses: est un oiseau; nage
 Conclusions: est un oiseau non volant
utilisee = false
Règle numéro 14: 
 Prémisses: est un oiseau non volant; a des pattes longues; a un long cou; est noir et blanc
 Conclusions: est une autruche
utilisee = false
Règle numéro 15: 
 Prémisses: est un oiseau non volant; a des pattes palmées; est noir et blanc
 Conclusions: est un pingouin
utilisee = false
Règle numéro 16: 
 Prémisses: est un oiseau; vole remarquablement
 Conclusions: est un albatros
utilisee = false
Base des faits:
a des poils; a des ongles; a un long cou; est brun; a des taches noires
- : unit = ()
*)

print_string "\nEffectuer le chainage avant";;
se#chainage_avant;;

(* Résultat:
- : int = 3
*)

print_string "\nAfficher le systeme expert";;
se#afficher_sexpert;;

(* Résultat:
Base des règles:
Règle numéro 1: 
 Prémisses: a des poils
 Conclusions: est un mammifère
utilisee = true
Règle numéro 2: 
 Prémisses: nourrit ses petits au lait
 Conclusions: est un mammifère
utilisee = false
Règle numéro 3: 
 Prémisses: a des plumes
 Conclusions: est un oiseau
utilisee = false
Règle numéro 4: 
 Prémisses: vole; pond des oeufs
 Conclusions: est un oiseau
utilisee = false
Règle numéro 5: 
 Prémisses: est un mammifère; mange de la viande
 Conclusions: est un carnivore
utilisee = false
Règle numéro 6: 
 Prémisses: est un mammifère; a les yeux dirigés en avant; a des dents pointues; a des griffes
 Conclusions: est un carnivore
utilisee = false
Règle numéro 7: 
 Prémisses: est un mammifère; a des ongles
 Conclusions: est un ongulé
utilisee = true
Règle numéro 8: 
 Prémisses: est un carnivore; est brun; a des taches noires
 Conclusions: est un guépard
utilisee = false
Règle numéro 9: 
 Prémisses: est un carnivore; est brun; a des raies noires
 Conclusions: est un tigre
utilisee = false
Règle numéro 10: 
 Prémisses: est un ongulé; a un long cou; est brun; a des taches noires
 Conclusions: est une girafe
utilisee = true
Règle numéro 11: 
 Prémisses: est un ongulé; est blanc; a des raies noires
 Conclusions: est un zèbre
utilisee = false
Règle numéro 12: 
 Prémisses: est un oiseau; ne vole pas
 Conclusions: est un oiseau non volant
utilisee = false
Règle numéro 13: 
 Prémisses: est un oiseau; nage
 Conclusions: est un oiseau non volant
utilisee = false
Règle numéro 14: 
 Prémisses: est un oiseau non volant; a des pattes longues; a un long cou; est noir et blanc
 Conclusions: est une autruche
utilisee = false
Règle numéro 15: 
 Prémisses: est un oiseau non volant; a des pattes palmées; est noir et blanc
 Conclusions: est un pingouin
utilisee = false
Règle numéro 16: 
 Prémisses: est un oiseau; vole remarquablement
 Conclusions: est un albatros
utilisee = false
Base des faits:
a des poils; a des ongles; a un long cou; est brun; a des taches noires; est un mammifère; est un ongulé; est une girafe
- : unit = ()
*)

print_string "\nVerifie si le fait est une girafe est present";;
se#fait_existe "est une girafe";;

(* Résultat:
- : bool = true
*)

print_string "\nVider la base des faits";;
se#vider_base_faits;;

(* Résultat:
- : unit = ()
*)

print_string "\nReinitialiser les regles utilisee";;
se#initialiser_utilisee_regles;;

(* Résultat:
- : unit = ()
*)

print_string "\nAfficher le systeme expert";;
se#afficher_sexpert;;

(* Résultat:
Base des règles:
Règle numéro 1: 
 Prémisses: a des poils
 Conclusions: est un mammifère
utilisee = false
Règle numéro 2: 
 Prémisses: nourrit ses petits au lait
 Conclusions: est un mammifère
utilisee = false
Règle numéro 3: 
 Prémisses: a des plumes
 Conclusions: est un oiseau
utilisee = false
Règle numéro 4: 
 Prémisses: vole; pond des oeufs
 Conclusions: est un oiseau
utilisee = false
Règle numéro 5: 
 Prémisses: est un mammifère; mange de la viande
 Conclusions: est un carnivore
utilisee = false
Règle numéro 6: 
 Prémisses: est un mammifère; a les yeux dirigés en avant; a des dents pointues; a des griffes
 Conclusions: est un carnivore
utilisee = false
Règle numéro 7: 
 Prémisses: est un mammifère; a des ongles
 Conclusions: est un ongulé
utilisee = false
Règle numéro 8: 
 Prémisses: est un carnivore; est brun; a des taches noires
 Conclusions: est un guépard
utilisee = false
Règle numéro 9: 
 Prémisses: est un carnivore; est brun; a des raies noires
 Conclusions: est un tigre
utilisee = false
Règle numéro 10: 
 Prémisses: est un ongulé; a un long cou; est brun; a des taches noires
 Conclusions: est une girafe
utilisee = false
Règle numéro 11: 
 Prémisses: est un ongulé; est blanc; a des raies noires
 Conclusions: est un zèbre
utilisee = false
Règle numéro 12: 
 Prémisses: est un oiseau; ne vole pas
 Conclusions: est un oiseau non volant
utilisee = false
Règle numéro 13: 
 Prémisses: est un oiseau; nage
 Conclusions: est un oiseau non volant
utilisee = false
Règle numéro 14: 
 Prémisses: est un oiseau non volant; a des pattes longues; a un long cou; est noir et blanc
 Conclusions: est une autruche
utilisee = false
Règle numéro 15: 
 Prémisses: est un oiseau non volant; a des pattes palmées; est noir et blanc
 Conclusions: est un pingouin
utilisee = false
Règle numéro 16: 
 Prémisses: est un oiseau; vole remarquablement
 Conclusions: est un albatros
utilisee = false
Base des faits:
Liste vide
- : unit = ()
*)

print_string "\nAjout d'une liste de faits";;
se#ajouter_liste_faits ["a des poils";"a des dents pointues";"a des griffes";
			"a les yeux dirigés en avant"; "est brun"; "a des taches noires"];;

(* Résultat:
- : unit = ()
*)

print_string "\nAfficher le systeme expert";;
se#afficher_sexpert;;

(* Résultat:
Base des règles:
Règle numéro 1: 
 Prémisses: a des poils
 Conclusions: est un mammifère
utilisee = false
Règle numéro 2: 
 Prémisses: nourrit ses petits au lait
 Conclusions: est un mammifère
utilisee = false
Règle numéro 3: 
 Prémisses: a des plumes
 Conclusions: est un oiseau
utilisee = false
Règle numéro 4: 
 Prémisses: vole; pond des oeufs
 Conclusions: est un oiseau
utilisee = false
Règle numéro 5: 
 Prémisses: est un mammifère; mange de la viande
 Conclusions: est un carnivore
utilisee = false
Règle numéro 6: 
 Prémisses: est un mammifère; a les yeux dirigés en avant; a des dents pointues; a des griffes
 Conclusions: est un carnivore
utilisee = false
Règle numéro 7: 
 Prémisses: est un mammifère; a des ongles
 Conclusions: est un ongulé
utilisee = false
Règle numéro 8: 
 Prémisses: est un carnivore; est brun; a des taches noires
 Conclusions: est un guépard
utilisee = false
Règle numéro 9: 
 Prémisses: est un carnivore; est brun; a des raies noires
 Conclusions: est un tigre
utilisee = false
Règle numéro 10: 
 Prémisses: est un ongulé; a un long cou; est brun; a des taches noires
 Conclusions: est une girafe
utilisee = false
Règle numéro 11: 
 Prémisses: est un ongulé; est blanc; a des raies noires
 Conclusions: est un zèbre
utilisee = false
Règle numéro 12: 
 Prémisses: est un oiseau; ne vole pas
 Conclusions: est un oiseau non volant
utilisee = false
Règle numéro 13: 
 Prémisses: est un oiseau; nage
 Conclusions: est un oiseau non volant
utilisee = false
Règle numéro 14: 
 Prémisses: est un oiseau non volant; a des pattes longues; a un long cou; est noir et blanc
 Conclusions: est une autruche
utilisee = false
Règle numéro 15: 
 Prémisses: est un oiseau non volant; a des pattes palmées; est noir et blanc
 Conclusions: est un pingouin
utilisee = false
Règle numéro 16: 
 Prémisses: est un oiseau; vole remarquablement
 Conclusions: est un albatros
utilisee = false
Base des faits:
a des poils; a des dents pointues; a des griffes; a les yeux dirigés en avant; est brun; a des taches noires
- : unit = ()
*)

print_string "\nChainage arriere sur est un guepard";;
se#chainage_arriere "est un guépard";;

(* Résultat:
- : bool = true
*)

print_string "\nSupprimer la regle 1";;
se#supprimer_regle r1;;

(* Résultat:
- : unit = ()
*)

print_string "\nSupprimer le fait a des poils";;
se#supprimer_fait "a des poils";;

(* Résultat:
- : unit = ()
*)

print_string "\nVider la base des regles";;
se#vider_base_regles;;
(* Résultat:
- : unit = ()
*)

print_string "\nAfficher le systeme expert";;
se#afficher_sexpert;;

(* Résultat:
Base des règles:
Liste vide
Base des faits:
a des dents pointues; a des griffes; a les yeux dirigés en avant; est brun; a des taches noires
- : unit = ()
*)

(***************************************)
(* Verification des messages d'erreurs *)
(***************************************)

print_string "\nSupprimer une regle d'un systeme vide";;
try 
  ignore ((new sexpert_taxonomique "" "")#supprimer_regle r1)
with
  Failure s -> print_endline s;;

(* Résultat:
Le système expert est vide
- : unit = ()
*)

print_string "\nSupprimer une regle qui n'existe pas";;
try 
  ignore (se#supprimer_regle r1)
with
  Failure s -> print_endline s;;

(* Résultat:
Le système expert ne contient pas cette règle
- : unit = ()
*)

print_string "\nSupprimer un fait d'un systeme vide";;
try 
  ignore ((new sexpert_taxonomique "" "")#supprimer_fait "test")
with
  Failure s -> print_endline s;;

(* Résultat:
Le système expert est vide
- : unit = ()
*)

print_string "\nSupprimer un fait qui n'existe pas";;
try 
  ignore (se#supprimer_fait "fait existe pas")
with
  Failure s -> print_endline s;;

(* Résultat:
Le système expert ne contient pas ce fait
- : unit = ()
*)

print_string "\nChainage avant sur un systeme vide";;
try 
  ignore ((new sexpert_taxonomique "" "")#chainage_avant)
with
  Failure s -> print_endline s;;

(* Résultat:
Le système expert est vide
- : unit = ()
*)

print_string "\nChainage avant sur un systeme ne contenant aucune regle";;
try
  let s' = new sexpert_taxonomique "" "" in
  ignore (s'#ajouter_fait "a des poils");
  ignore (s'#chainage_avant)
with
  Failure s -> print_endline s;;

(* Résultat:
Le système expert ne contient pas de règles
- : unit = ()
*)

print_string "\nChainage avant sur un systeme qui ne contient pas de faits";;
try
  let s' = new sexpert_taxonomique "" "" in
  ignore (s'#ajouter_regle r1);
  ignore (s'#chainage_avant)
with
  Failure s -> print_endline s;;

(* Résultat:
Le système expert ne contient pas de faits
- : unit = ()
*)

print_string "\nChainage arriere sur un systeme sans regle";;
try
  let s' = new sexpert_taxonomique "" "" in
  ignore (s'#ajouter_fait "a des poils");
  ignore (s'#chainage_arriere "")
with
  Failure s -> print_endline s;;

(* Résultat:
Le système expert ne contient pas de règles
- : unit = ()
*)

print_string "\nChainage arriere sur un systeme sans faits";;
try
  let s' = new sexpert_taxonomique "" "" in
  ignore (s'#ajouter_regle r1);
  ignore (s'#chainage_arriere "")
with
  Failure s -> print_endline s;;

(* Résultat:
Le système expert ne contient pas de faits
- : unit = ()
*)
*)
