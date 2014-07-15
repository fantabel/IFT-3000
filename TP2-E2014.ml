(*******************************************************************)
(* Langages de Programmation: IFT 3000 NRC 51158                   *)
(* TP2 HIVER 2013. Date limite: mercredi 16 juillet à 17h00        *)
(* Enseignant: Mondher Bouden (ift3000-e2014@ift.ulaval.ca)        *)
(* Implanter un système expert en utilisant l'orienté objet        *)
(*******************************************************************)
(*                                                                 *)
(* NOM: _St-Hilaire____________ PRÉNOM:_Jimmy_____________________ *)
(* MATRICULE: _________________ PROGRAMME: Certificat Informatique *)
(*                                                                 *)
(*******************************************************************)
(*                                                                 *)
(* NOM: Deslauriers____________ PRÉNOM: Catherine_________________ *)
(* MATRICULE: 111 017 299______ PROGRAMME: Cert. en informatique__ *)
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

		(* M�thodes � implanter *)

		(* regle_existe : regle -> bool *)
		method regle_existe (r:regle) = match base_regles with
			| [] -> false
			| _ -> appartient r base_regles

		(* fait_existe : fait -> bool *)
		method fait_existe (f:fait) = match base_faits with
			| [] -> false
			| _ -> appartient f base_faits

		(* ajouter_regle : regle -> unit *)
		method ajouter_regle (r:regle) = match self#regle_existe r with
			| false -> self#set_base_regles (base_regles @ [r])
			| true -> failwith "La regle existe deja"

		(* supprimer_regle : regle -> unit *)
		method supprimer_regle (r:regle) = 
			if self#regle_existe r then
				let (l1, l2) = partition (fun x -> x = r) self#get_base_regles in self#set_base_regles (l2)
			else if self#get_base_regles != [] && self#get_base_faits != [] then
				failwith "Le système expert est vide"
			else
				failwith "Le système expert ne contient pas cette règle"

		(* ajouter_fait : fait -> unit *)
		method ajouter_fait (f:fait) = match self#fait_existe f with
			| false -> self#set_base_faits (base_faits @ [f])
			| true -> failwith "Le fait existe deja"

		(* supprimer_fait : fait -> unit *)
		method supprimer_fait (f:fait) =
			if self#fait_existe f then
				let (l1, l2) = partition (fun x -> x = f) self#get_base_faits in self#set_base_faits (l2)
			else if self#get_base_regles != [] && self#get_base_faits != [] then
				failwith "Le système expert est vide"
			else
				print_string "Le système expert ne contient pas ce fait"

		(* vider_base_regles : unit *)
		method vider_base_regles =
			base_regles <- []

		(* vider_base_faits : unit *)
		method vider_base_faits = 
			base_faits <- []

		(* initialiser_utilisee_regles : unit *)
		method initialiser_utilisee_regles =
			iter (fun x -> x#set_utilisee false) self#get_base_regles

		(* ajouter_liste_regles : (fait list * fait list) list -> unit *)
		method ajouter_liste_regles (lr:(fait list * fait list) list) =
			iter (fun (l1, l2) -> self#ajouter_regle (new regle l1 l2 false)) lr

		(* ajouter_liste_faits : fait list -> unit *)
		method ajouter_liste_faits (lf:fait list) = 
			iter (fun x -> self#ajouter_fait x) lf

		(* afficher_sexpert : unit *)
		method afficher_sexpert = 
			let print_element elem pos len =
				if pos != len then
					print_string (elem ^ "; ")
				else
					print_string (elem ^ "\n") in
			let longueur l = (length l) - 1 in
			let afficher_liste uneListe = iteri (fun i x -> print_element x i (longueur uneListe)) uneListe in
			let afficher_premisses listePremisses = print_string " Prémisses: " ; afficher_liste listePremisses in
			let afficher_conclusions listeConclusions = print_string " Conclusions: " ; afficher_liste listeConclusions in
			let afficher_regles listeDeRegles =
				iteri (fun i x -> print_string ("Règle numero " ^ string_of_int (i + 1) ^ ":\n") ;
				afficher_premisses x#get_premisses ;
				afficher_conclusions x#get_conclusions ;
				print_string ("utilisee = " ^ string_of_bool x#get_utilisee ^ "\n")) listeDeRegles in
			print_string "Base des règles:\n" ;
			match self#get_base_regles with
				| [] -> print_string "Liste vide\n"
				| _ -> afficher_regles self#get_base_regles ;
			print_string "Base des faits:\n" ;
			match self#get_base_faits with
				| [] -> print_string "Liste vide\n"
				| _ -> afficher_liste self#get_base_faits

		(* chainage_avant : int *)
		method chainage_avant = match self#get_base_faits, self#get_base_regles with
						| [],[] -> failwith "Le système expert est vide"
			| _,[] -> failwith "Le système expert ne contient pas de règles"
			| [],_ -> failwith "Le système expert ne contient pas de faits"
			| lf,lr ->
				let lf' = ref lf in
				let sature = ref false in
				let faits_ajoutes = ref 0 in

				while (not !sature) do  (* Processus de saturation *)
				        sature := true;
					for i = 0 to (length lr) - 1 do (* Parcourir les règles *)
						let reg = nth lr i in (* Récupère la règle à vérifier *)
						if (reg#get_utilisee) = false then begin
									reg#set_utilisee true;
									let lp = reg#get_premisses in
									for j = 0 to (length lp) - 1 do (* Parcourir les prémisses *)
											let prem = nth lp j in (* Récupère la prémisse à vérifier *)
											if (not (appartient prem !lf')) then begin
													reg#set_utilisee false;
											end;
									done;

									if (reg#get_utilisee) then begin (*Si la règle est vérifiée *)
											(* Ajoute les conclusions aux nouveaux faits *)
											let lc = reg#get_conclusions in
											for k = 0 to (length lc) - 1 do (* Parcourir les conclusions *)
												let conc = nth lc k in (* Récupère la conclusion à vérifier *)
												if (not (appartient conc !lf')) then begin
													lf' := !lf' @ [conc];
													faits_ajoutes := !faits_ajoutes + 1;
												end;
											done;
											sature := false; (* On recommence avec les règles *)
									end else begin
										sature := true; (* Le système est saturé *)
									end;
						 end;
					done;
				done;

				!faits_ajoutes;

		(* chainage_arriere : fait -> bool *)
		method chainage_arriere (f:fait) = 
			let rec chainage_arriere_rec (h:fait) = match self#get_base_faits, self#get_base_regles with
				| [],[] -> failwith "Le système expert est vide"
				| _,[] -> failwith "Le système expert ne contient pas de règles"
				| [],_ -> failwith "Le système expert ne contient pas de faits"
				| lf,lr ->
					print_string ("Recherche de conclusion " ^ h ^ "\n");
					let verifie = ref false in
					for i = 0 to (length lr) - 1 do (* Parcourir les règles *)
						let reg = nth lr i in
						let lc = reg#get_conclusions in
						for j = 0 to (length lc) - 1 do (* Parcourir les conclusions *)
							if (!verifie = false) then begin
								let conc = nth lc j in (* Récupère la conclusion à vérifier *)
								if conc = h then begin
									print_string ("Conclusion trouve : " ^ h ^ "\n");
									verifie := true;
									let lp = reg#get_premisses in
									for k = 0 to (length lp) - 1 do
										let prem = nth lp k in
										print_string ("Verifier premise : " ^ prem ^ " - " ^ conc ^ "\n");
										if (appartient prem lf)
										then begin
											print_string ("  Premise " ^ prem ^ " present dans la liste des faits\n") end
										else if chainage_arriere_rec prem
										then begin
											print_string ("  Premise " ^ prem ^ " verifiable par hypothese\n") end
										else begin
											print_string ("  Premise " ^ prem ^ " non verifiable\n");
											verifie := false
										end;
									done;
								end;
							end;
						done;
					done;
					!verifie in 
						chainage_arriere_rec f;


	end

end

