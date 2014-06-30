(* regle_existe : regle -> bool *)  
~~method regle_existe (r:regle) = false~~
			
(* fait_existe : fait -> bool *)  
~~method fait_existe (f:fait) = false~~

(* ajouter_regle : regle -> unit *)  
~~method ajouter_regle (r:regle) = ()~~

(* supprimer_regle : regle -> unit *)  
method supprimer_regle (r:regle) = ()

(* ajouter_fait : fait -> unit *)  
 ?method ajouter_fait (f:fait) = ()

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
~~method afficher_sexpert = ()~~

(* chainage_avant : int *)  
method chainage_avant = 0

(* chainage_arriere : fait -> bool *)  
method chainage_arriere (f:fait) = true
