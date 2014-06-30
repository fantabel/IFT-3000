(*******************************************************************)
(* Langages de Programmation: IFT 3000 NRC 51158                   *)
(* TP2 HIVER 2013. Date limite: mercredi 16 juillet à 17h00        *)
(* Enseignant: Mondher Bouden (ift3000-e2014@ift.ulaval.ca)        *)
(* Implanter un système expert en utilsiant l'orienté objet        *)
(*******************************************************************)
(*                                                                 *)
(* NOM: _St-Hilaire____________ PRÉNOM:_Jimmy_____________________ *)
(* MATRICULE: _________________ PROGRAMME: Certificat Informatique *)
(*                                                                 *)
(*******************************************************************)
(*                                                                 *)
(* NOM: _______________________ PRÉNOM:___________________________ *)
(* MATRICULE: _________________ PROGRAMME: _______________________ *)
(*                                                                 *)
(*******************************************************************)


(* Charger la signature du TP2 *)
#use "TP2-SIG-E2014.mli";;

module Tp2e14 : TP2E14 = struct

	open List

	type fait = string

	let appartient e l = exists (function x -> x = e) l

	let enlever e l = let (l1, l2) = partition (function x -> x = e) l in l2

	let remplacer e e' l = map (fun x -> (if (x = e) then e' else x)) l

	class regle (p: fait list) (c: fait list) (u: bool) = object
		val premisses : fait list = p
		val conclusions : fait list = c
		val mutable utilisee : bool = u
		method get_premisses = premisses
		method get_conclusions = conclusions
		method get_utilisee = utilisee
		method set_utilisee (vu : bool) = utilisee <- vu
	end

	class sexpert (ss:string) = object
		val sorte_sexpert : string = ss
		method get_sorte_sexpert = sorte_sexpert
	end

	class sexpert_taxonomique (ss:string) (ns:string) = object(self)
		inherit sexpert ss as parent
		val nom_sexpert : string = ns
		val mutable base_regles : regle list = []
		val mutable base_faits : fait list = []
		method get_nom_sexpert = nom_sexpert
		method get_base_regles = base_regles
		method get_base_faits = base_faits
		method set_base_regles (lr : regle list) = base_regles <- lr
		method set_base_faits (lf : fait list) = base_faits <- lf
		initializer print_string ("Nouveau " ^ 
                                  (parent#get_sorte_sexpert) ^ ": " ^ 
                                  (self#get_nom_sexpert)) ; print_newline()

		(* Méthodes à implanter *)

		(* regle_existe : regle -> bool *)
		method regle_existe (r:regle) = match base_regles with
			| [] -> false
			| _ -> appartient r base_regles

		(* fait_existe : fait -> bool *)
		method fait_existe (f:fait) = match base_faits with
			| [] -> false
			| _ -> appartient f base_faits

		(* ajouter_regle : regle -> unit *)
		method ajouter_regle (r:regle) = self#set_base_regles (base_regles @ [r])

		(* supprimer_regle : regle -> unit *)
		method supprimer_regle (r:regle) = ()

		(* ajouter_fait : fait -> unit *)
		method ajouter_fait (f:fait) = ()

		(* supprimer_fait : fait -> unit *)
		method supprimer_fait (f:fait) = ()

		(* vider_base_regles : unit *)
		method vider_base_regles = ()

		(* vider_base_faits : unit *)
		method vider_base_faits = ()

		(* intialiser_utilisee_regles : unit *)
		method initialiser_utilisee_regles = ()

		(* ajouter_liste_regles : (fait list * fait list) list -> unit *)
		method ajouter_liste_regles (lr:(fait list * fait list) list) = ()

		(* ajouter_liste_faits : fait list -> unit *)
		method ajouter_liste_faits (lf:fait list) = ()

		(* afficher_sexpert : unit *)
		method afficher_sexpert = 
			let print_element elem pos len =
				if pos != len then
					print_string (elem ^ "; ")
				else
					print_string (elem ^ "\n") in
			let longueur l = (length l) - 1 in
			let afficher_liste uneListe = iteri (fun i x -> print_element x i (longueur uneListe)) uneListe in
			let afficher_premisses listePremisses = print_string " Premisses: " ; afficher_liste listePremisses in
			let afficher_conclusions listeConclusions = print_string " Conclusions: " ; afficher_liste listeConclusions in
			let afficher_regles listeDeRegles =
				iteri (fun i x -> print_string ("Regle numero " ^ string_of_int (i + 1) ^ "\n") ;
				afficher_premisses x#get_premisses ;
				afficher_conclusions x#get_conclusions) listeDeRegles in
			print_string "Base des regles:\n" ;
			afficher_regles self#get_base_regles ;
			print_string "Base des faits\n" ;
			afficher_liste self#get_base_faits

		(* chainage_avant : int *)
		method chainage_avant = 0

		(* chainage_arriere : fait -> bool *)
		method chainage_arriere (f:fait) = true

	end

end

