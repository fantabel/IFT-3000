(***************************************************************************) 
(* Jeu d'essai - TP2 - �T� 2014                                            *) 
(***************************************************************************)

(* Pour changer ou obtenir le r�pertoire courant
Sys.getcwd ();;
Sys.chdir;; 
*)

(* Pour afficher les listes avec plus de �profondeurs�:
#print_depth 1000;;
#print_length 1000;;
*)

(* On charge le fichier ml du Tp apr�s avoir implant� 
les m�thodes demand�es pour realiser les tests  *)
print_string "\nChargement du fichier TP2-E2014.ml\n";;
print_string "==================================\n";;
#use "TP2-E2014.ml";;

(* R�sultat:
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

(* On ex�cute maintenant les m�thodes une � une *)

print_string "\nCreation du systeme expert taxonomique.\n";;
print_string "=======================================\n";;
let se = new sexpert_taxonomique "Syst�me expert taxonomique" "Classer des esp�ces animales";;

(* R�sultat:
Nouveau Syst�me expert taxonomique: Classer des esp�ces animales
val se : Tp2e14.sexpert_taxonomique = <obj>
*)

print_string "\nCreation d'une regle\n";;
print_string "====================";;
let r1 = new regle ["a des poils"] ["est un mammif�re"] false;;

(* R�sultat:
val r1 : Tp2e14.regle = <obj>
*)

print_string "\nAjout de la regle au systeme expert\n";;
print_string "===================================";;
se#ajouter_regle r1;;

(* R�sultat:
- : unit = ()
*)

print_string "\nAffichage du systeme expert\n";;
print_string "===========================\n";;
se#afficher_sexpert;;

(* R�sultat:
Base des r�gles:
R�gle num�ro 1: 
 Pr�misses: a des poils
 Conclusions: est un mammif�re
utilisee = false
Base des faits:
Liste vide
- : unit = ()
*)

print_string "\nAjout une liste de regles au systeme expert\n";;
print_string "===========================================";;
se#ajouter_liste_regles
    [(["nourrit ses petits au lait"], ["est un mammif�re"]);
     (["a des plumes"],["est un oiseau"]);
     (["vole";"pond des oeufs"], ["est un oiseau"]);
     (["est un mammif�re";"mange de la viande"],["est un carnivore"]);
     (["est un mammif�re";"a les yeux dirig�s en avant";"a des dents pointues";"a des griffes"],["est un carnivore"]);
     ["est un mammif�re";"a des ongles"],["est un ongul�"];
     (["est un carnivore";"est brun";"a des taches noires"],["est un gu�pard"]);
     (["est un carnivore";"est brun";"a des raies noires"],["est un tigre"]);
     (["est un ongul�";"a un long cou";"est brun";"a des taches noires"],["est une girafe"]);
     (["est un ongul�";"est blanc";"a des raies noires"],["est un z�bre"]);
     (["est un oiseau";"ne vole pas"],["est un oiseau non volant"]);
     (["est un oiseau";"nage"],["est un oiseau non volant"]);
     (["est un oiseau non volant";"a des pattes longues";"a un long cou";"est noir et blanc"],["est une autruche"]);
     (["est un oiseau non volant";"a des pattes palm�es";"est noir et blanc"],["est un pingouin"]);
     (["est un oiseau";"vole remarquablement"],["est un albatros"])];;

(* R�sultat:
- : unit = ()
*)

print_string "\nVerification de la presence de la premiere regle ajoute au Systeme\n";;
print_string
"==================================================================";;
se#regle_existe r1;;

(* R�sultat:
- : bool = true
*)

print_string "\nAjoute un fait au systeme expert";;
print_string "\n================================";;
se#ajouter_fait "a des poils";;
(* R�sultat:
- : unit = ()
*)
print_string "\nAjouter une liste de fait au systeme expert";;
print_string "\n===========================================";;
se#ajouter_liste_faits ["a des ongles";"a un long cou";"est brun";"a des taches noires"];;

(* R�sultat:
- : unit = ()
*)

print_string "\nAfficher le systeme expert";;
print_string "\n==========================\n";;
se#afficher_sexpert;;

(* R�sultat:
Base des r�gles:
R�gle num�ro 1: 
 Pr�misses: a des poils
 Conclusions: est un mammif�re
utilisee = false
R�gle num�ro 2: 
 Pr�misses: nourrit ses petits au lait
 Conclusions: est un mammif�re
utilisee = false
R�gle num�ro 3: 
 Pr�misses: a des plumes
 Conclusions: est un oiseau
utilisee = false
R�gle num�ro 4: 
 Pr�misses: vole; pond des oeufs
 Conclusions: est un oiseau
utilisee = false
R�gle num�ro 5: 
 Pr�misses: est un mammif�re; mange de la viande
 Conclusions: est un carnivore
utilisee = false
R�gle num�ro 6: 
 Pr�misses: est un mammif�re; a les yeux dirig�s en avant; a des dents pointues; a des griffes
 Conclusions: est un carnivore
utilisee = false
R�gle num�ro 7: 
 Pr�misses: est un mammif�re; a des ongles
 Conclusions: est un ongul�
utilisee = false
R�gle num�ro 8: 
 Pr�misses: est un carnivore; est brun; a des taches noires
 Conclusions: est un gu�pard
utilisee = false
R�gle num�ro 9: 
 Pr�misses: est un carnivore; est brun; a des raies noires
 Conclusions: est un tigre
utilisee = false
R�gle num�ro 10: 
 Pr�misses: est un ongul�; a un long cou; est brun; a des taches noires
 Conclusions: est une girafe
utilisee = false
R�gle num�ro 11: 
 Pr�misses: est un ongul�; est blanc; a des raies noires
 Conclusions: est un z�bre
utilisee = false
R�gle num�ro 12: 
 Pr�misses: est un oiseau; ne vole pas
 Conclusions: est un oiseau non volant
utilisee = false
R�gle num�ro 13: 
 Pr�misses: est un oiseau; nage
 Conclusions: est un oiseau non volant
utilisee = false
R�gle num�ro 14: 
 Pr�misses: est un oiseau non volant; a des pattes longues; a un long cou; est noir et blanc
 Conclusions: est une autruche
utilisee = false
R�gle num�ro 15: 
 Pr�misses: est un oiseau non volant; a des pattes palm�es; est noir et blanc
 Conclusions: est un pingouin
utilisee = false
R�gle num�ro 16: 
 Pr�misses: est un oiseau; vole remarquablement
 Conclusions: est un albatros
utilisee = false
Base des faits:
a des poils; a des ongles; a un long cou; est brun; a des taches noires
- : unit = ()
*)

print_string "\nEffectuer le chainage avant";;
print_string "\n===========================";;
se#chainage_avant;;

(* R�sultat:
- : int = 3
*)

print_string "\nAfficher le systeme expert";;
print_string "\n==========================\n";;
se#afficher_sexpert;;

(* R�sultat:
Base des r�gles:
R�gle num�ro 1: 
 Pr�misses: a des poils
 Conclusions: est un mammif�re
utilisee = true
R�gle num�ro 2: 
 Pr�misses: nourrit ses petits au lait
 Conclusions: est un mammif�re
utilisee = false
R�gle num�ro 3: 
 Pr�misses: a des plumes
 Conclusions: est un oiseau
utilisee = false
R�gle num�ro 4: 
 Pr�misses: vole; pond des oeufs
 Conclusions: est un oiseau
utilisee = false
R�gle num�ro 5: 
 Pr�misses: est un mammif�re; mange de la viande
 Conclusions: est un carnivore
utilisee = false
R�gle num�ro 6: 
 Pr�misses: est un mammif�re; a les yeux dirig�s en avant; a des dents pointues; a des griffes
 Conclusions: est un carnivore
utilisee = false
R�gle num�ro 7: 
 Pr�misses: est un mammif�re; a des ongles
 Conclusions: est un ongul�
utilisee = true
R�gle num�ro 8: 
 Pr�misses: est un carnivore; est brun; a des taches noires
 Conclusions: est un gu�pard
utilisee = false
R�gle num�ro 9: 
 Pr�misses: est un carnivore; est brun; a des raies noires
 Conclusions: est un tigre
utilisee = false
R�gle num�ro 10: 
 Pr�misses: est un ongul�; a un long cou; est brun; a des taches noires
 Conclusions: est une girafe
utilisee = true
R�gle num�ro 11: 
 Pr�misses: est un ongul�; est blanc; a des raies noires
 Conclusions: est un z�bre
utilisee = false
R�gle num�ro 12: 
 Pr�misses: est un oiseau; ne vole pas
 Conclusions: est un oiseau non volant
utilisee = false
R�gle num�ro 13: 
 Pr�misses: est un oiseau; nage
 Conclusions: est un oiseau non volant
utilisee = false
R�gle num�ro 14: 
 Pr�misses: est un oiseau non volant; a des pattes longues; a un long cou; est noir et blanc
 Conclusions: est une autruche
utilisee = false
R�gle num�ro 15: 
 Pr�misses: est un oiseau non volant; a des pattes palm�es; est noir et blanc
 Conclusions: est un pingouin
utilisee = false
R�gle num�ro 16: 
 Pr�misses: est un oiseau; vole remarquablement
 Conclusions: est un albatros
utilisee = false
Base des faits:
a des poils; a des ongles; a un long cou; est brun; a des taches noires; est un mammif�re; est un ongul�; est une girafe
- : unit = ()
*)

print_string "\nVerifie si le fait est une girafe est present";;
print_string "\n=============================================";;
se#fait_existe "est une girafe";;

(* R�sultat:
- : bool = true
*)

print_string "\nVider la base des faits";;
print_string "\n=======================";;
se#vider_base_faits;;

(* R�sultat:
- : unit = ()
*)

print_string "\nReinitialiser les regles utilisee";;
print_string "\n=================================";;
se#initialiser_utilisee_regles;;

(* R�sultat:
- : unit = ()
*)

print_string "\nAfficher le systeme expert";;
print_string "\n==========================\n";;
se#afficher_sexpert;;

(* R�sultat:
Base des r�gles:
R�gle num�ro 1: 
 Pr�misses: a des poils
 Conclusions: est un mammif�re
utilisee = false
R�gle num�ro 2: 
 Pr�misses: nourrit ses petits au lait
 Conclusions: est un mammif�re
utilisee = false
R�gle num�ro 3: 
 Pr�misses: a des plumes
 Conclusions: est un oiseau
utilisee = false
R�gle num�ro 4: 
 Pr�misses: vole; pond des oeufs
 Conclusions: est un oiseau
utilisee = false
R�gle num�ro 5: 
 Pr�misses: est un mammif�re; mange de la viande
 Conclusions: est un carnivore
utilisee = false
R�gle num�ro 6: 
 Pr�misses: est un mammif�re; a les yeux dirig�s en avant; a des dents pointues; a des griffes
 Conclusions: est un carnivore
utilisee = false
R�gle num�ro 7: 
 Pr�misses: est un mammif�re; a des ongles
 Conclusions: est un ongul�
utilisee = false
R�gle num�ro 8: 
 Pr�misses: est un carnivore; est brun; a des taches noires
 Conclusions: est un gu�pard
utilisee = false
R�gle num�ro 9: 
 Pr�misses: est un carnivore; est brun; a des raies noires
 Conclusions: est un tigre
utilisee = false
R�gle num�ro 10: 
 Pr�misses: est un ongul�; a un long cou; est brun; a des taches noires
 Conclusions: est une girafe
utilisee = false
R�gle num�ro 11: 
 Pr�misses: est un ongul�; est blanc; a des raies noires
 Conclusions: est un z�bre
utilisee = false
R�gle num�ro 12: 
 Pr�misses: est un oiseau; ne vole pas
 Conclusions: est un oiseau non volant
utilisee = false
R�gle num�ro 13: 
 Pr�misses: est un oiseau; nage
 Conclusions: est un oiseau non volant
utilisee = false
R�gle num�ro 14: 
 Pr�misses: est un oiseau non volant; a des pattes longues; a un long cou; est noir et blanc
 Conclusions: est une autruche
utilisee = false
R�gle num�ro 15: 
 Pr�misses: est un oiseau non volant; a des pattes palm�es; est noir et blanc
 Conclusions: est un pingouin
utilisee = false
R�gle num�ro 16: 
 Pr�misses: est un oiseau; vole remarquablement
 Conclusions: est un albatros
utilisee = false
Base des faits:
Liste vide
- : unit = ()
*)

print_string "\nAjout d'une liste de faits";;
print_string "\n==========================";;
se#ajouter_liste_faits ["a des poils";"a des dents pointues";"a des griffes";
			"a les yeux dirig�s en avant"; "est brun"; "a des taches noires"];;

(* R�sultat:
- : unit = ()
*)

print_string "\nAfficher le systeme expert";;
print_string "\n==========================\n";;
se#afficher_sexpert;;

(* R�sultat:
Base des r�gles:
R�gle num�ro 1: 
 Pr�misses: a des poils
 Conclusions: est un mammif�re
utilisee = false
R�gle num�ro 2: 
 Pr�misses: nourrit ses petits au lait
 Conclusions: est un mammif�re
utilisee = false
R�gle num�ro 3: 
 Pr�misses: a des plumes
 Conclusions: est un oiseau
utilisee = false
R�gle num�ro 4: 
 Pr�misses: vole; pond des oeufs
 Conclusions: est un oiseau
utilisee = false
R�gle num�ro 5: 
 Pr�misses: est un mammif�re; mange de la viande
 Conclusions: est un carnivore
utilisee = false
R�gle num�ro 6: 
 Pr�misses: est un mammif�re; a les yeux dirig�s en avant; a des dents pointues; a des griffes
 Conclusions: est un carnivore
utilisee = false
R�gle num�ro 7: 
 Pr�misses: est un mammif�re; a des ongles
 Conclusions: est un ongul�
utilisee = false
R�gle num�ro 8: 
 Pr�misses: est un carnivore; est brun; a des taches noires
 Conclusions: est un gu�pard
utilisee = false
R�gle num�ro 9: 
 Pr�misses: est un carnivore; est brun; a des raies noires
 Conclusions: est un tigre
utilisee = false
R�gle num�ro 10: 
 Pr�misses: est un ongul�; a un long cou; est brun; a des taches noires
 Conclusions: est une girafe
utilisee = false
R�gle num�ro 11: 
 Pr�misses: est un ongul�; est blanc; a des raies noires
 Conclusions: est un z�bre
utilisee = false
R�gle num�ro 12: 
 Pr�misses: est un oiseau; ne vole pas
 Conclusions: est un oiseau non volant
utilisee = false
R�gle num�ro 13: 
 Pr�misses: est un oiseau; nage
 Conclusions: est un oiseau non volant
utilisee = false
R�gle num�ro 14: 
 Pr�misses: est un oiseau non volant; a des pattes longues; a un long cou; est noir et blanc
 Conclusions: est une autruche
utilisee = false
R�gle num�ro 15: 
 Pr�misses: est un oiseau non volant; a des pattes palm�es; est noir et blanc
 Conclusions: est un pingouin
utilisee = false
R�gle num�ro 16: 
 Pr�misses: est un oiseau; vole remarquablement
 Conclusions: est un albatros
utilisee = false
Base des faits:
a des poils; a des dents pointues; a des griffes; a les yeux dirig�s en avant; est brun; a des taches noires
- : unit = ()
*)

print_string "\nChainage arriere sur est un guepard";;
print_string "\n===================================\n";;
se#chainage_arriere "est un gu�pard";;

(* R�sultat:
- : bool = true
*)

print_string "\nSupprimer la regle 1";;
se#supprimer_regle r1;;

(* R�sultat:
- : unit = ()
*)

print_string "\nSupprimer le fait a des poils";;
se#supprimer_fait "a des poils";;

(* R�sultat:
- : unit = ()
*)

print_string "\nVider la base des regles";;
se#vider_base_regles;;
(* R�sultat:
- : unit = ()
*)

print_string "\nAfficher le systeme expert";;
se#afficher_sexpert;;

(* R�sultat:
Base des r�gles:
Liste vide
Base des faits:
a des dents pointues; a des griffes; a les yeux dirig�s en avant; est brun; a des taches noires
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

(* R�sultat:
Le syst�me expert est vide
- : unit = ()
*)

print_string "\nSupprimer une regle qui n'existe pas";;
try 
  ignore (se#supprimer_regle r1)
with
  Failure s -> print_endline s;;

(* R�sultat:
Le syst�me expert ne contient pas cette r�gle
- : unit = ()
*)

print_string "\nSupprimer un fait d'un systeme vide";;
try 
  ignore ((new sexpert_taxonomique "" "")#supprimer_fait "test")
with
  Failure s -> print_endline s;;

(* R�sultat:
Le syst�me expert est vide
- : unit = ()
*)

print_string "\nSupprimer un fait qui n'existe pas";;
try 
  ignore (se#supprimer_fait "fait existe pas")
with
  Failure s -> print_endline s;;

(* R�sultat:
Le syst�me expert ne contient pas ce fait
- : unit = ()
*)

print_string "\nChainage avant sur un systeme vide";;
try 
  ignore ((new sexpert_taxonomique "" "")#chainage_avant)
with
  Failure s -> print_endline s;;

(* R�sultat:
Le syst�me expert est vide
- : unit = ()
*)

print_string "\nChainage avant sur un systeme ne contenant aucune regle";;
try
  let s' = new sexpert_taxonomique "" "" in
  ignore (s'#ajouter_fait "a des poils");
  ignore (s'#chainage_avant)
with
  Failure s -> print_endline s;;

(* R�sultat:
Le syst�me expert ne contient pas de r�gles
- : unit = ()
*)

print_string "\nChainage avant sur un systeme qui ne contient pas de faits";;
try
  let s' = new sexpert_taxonomique "" "" in
  ignore (s'#ajouter_regle r1);
  ignore (s'#chainage_avant)
with
  Failure s -> print_endline s;;

(* R�sultat:
Le syst�me expert ne contient pas de faits
- : unit = ()
*)

print_string "\nChainage arriere sur un systeme sans regle";;
try
  let s' = new sexpert_taxonomique "" "" in
  ignore (s'#ajouter_fait "a des poils");
  ignore (s'#chainage_arriere "")
with
  Failure s -> print_endline s;;

(* R�sultat:
Le syst�me expert ne contient pas de r�gles
- : unit = ()
*)

print_string "\nChainage arriere sur un systeme sans faits";;
try
  let s' = new sexpert_taxonomique "" "" in
  ignore (s'#ajouter_regle r1);
  ignore (s'#chainage_arriere "")
with
  Failure s -> print_endline s;;

(* R�sultat:
Le syst�me expert ne contient pas de faits
- : unit = ()
*)

