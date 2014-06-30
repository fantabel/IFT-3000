(*****************************************************************)
(* Langages de Programmation: IFT 3000 NRC 51158                 *)
(* TP2 ÉTÉ 2014. Date limite: Mercreci 16 juillet à 17h          *)
(* Enseignant: Mondher Bouden (ift3000-e2014@ift.ulaval.ca)      *)  
(* Implanter un système expert en utilsiant l'orienté objet      *)
(*****************************************************************)
(*****************************************************************) 
(* Signature du Système Expert   	                         *)  
(*****************************************************************)

module type TP2E14 =
  sig

    type fait = string

    class regle : fait list -> fait list -> bool ->
      object
	val premisses : fait list 
	val conclusions : fait list
	val mutable utilisee : bool
	method get_premisses : fait list
	method get_conclusions : fait list
	method get_utilisee : bool
	method set_utilisee : bool -> unit
      end

    class sexpert : string ->
      object
	val sorte_sexpert : string 
	method get_sorte_sexpert : string
      end

    class sexpert_taxonomique : string -> string ->
      object
	inherit sexpert
	val nom_sexpert : string
	val mutable base_regles : regle list
	val mutable base_faits : fait list
	method get_nom_sexpert : string
	method get_base_regles : regle list
	method get_base_faits : fait list
	method set_base_regles : regle list -> unit
	method set_base_faits : fait list -> unit

	method regle_existe : regle -> bool
	method fait_existe : fait -> bool
	method ajouter_regle : regle -> unit
	method supprimer_regle : regle -> unit
	method ajouter_fait : fait -> unit
	method supprimer_fait : fait -> unit
	method vider_base_regles : unit
        method vider_base_faits : unit
	method initialiser_utilisee_regles : unit
	method ajouter_liste_regles : (fait list * fait list) list -> unit
        method ajouter_liste_faits : fait list -> unit
        method afficher_sexpert : unit
        method chainage_avant : int
        method chainage_arriere : fait -> bool
      end

  end
