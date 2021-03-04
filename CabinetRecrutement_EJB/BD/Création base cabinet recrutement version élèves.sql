-- Titre :             Création base cabinet recrutement version élèves.sql
-- Version :           1.0
-- Date création :     28 juin 2011
-- Date modification : 16 janvier 2021
-- Auteur :            Philippe Tanguy
-- Description :       Script de création de la base de données pour le SI "gestion de cabinet de
--                     recrutement"
--                     Note : script pour PostgreSQL
--                     Ebauche du script : ne contient pour le moment que la table "entreprise".

-- +----------------------------------------------------------------------------------------------+
-- | Suppression des tables                                                                       |
-- +----------------------------------------------------------------------------------------------+

drop table if exists message_offre_demploi;
drop table if exists message_candidature;
drop table if exists detail_candidature;
drop table if exists detail_offre_emploi;
drop table if exists offre_emploi;
drop table if exists candidature;
drop table if exists entreprise;
drop table if exists niveau_qualification;
drop table if exists secteur_activite;









-- +----------------------------------------------------------------------------------------------+
-- | Création des tables                                                                          |
-- +----------------------------------------------------------------------------------------------+

create table entreprise
(
  id              serial primary key,
  nom             varchar(50),
  descriptif      text,
  adresse_postale varchar(30) -- Pour simplifier, adresse_postale = ville.
);

CREATE TABLE niveau_qualification 
(
	id serial primary key,
	intitule varchar(50)
);

CREATE TABLE secteur_activite 
(
	id serial primary key,
	intitule varchar(50)
);

CREATE TABLE candidature 
(
	id serial primary key,
	nom varchar(50),
	prenom varchar(50),
	dateNaissance date,
	adressePostale varchar(50),
	adresseEmail varchar(50),
	CV text,
	dateDepot date,
	niveau_qualification int not null REFERENCES niveau_qualification(id)
);


CREATE TABLE detail_candidature 
(
	candidature int not null REFERENCES candidature(id),
	secteur_activite int not null REFERENCES secteur_activite(id),
	primary key(candidature,secteur_activite)
);


CREATE TABLE offre_emploi 
(
	id serial primary key,
	titre varchar(50),
	descriptifMission text,
	profilRecherche text,
	dateDepot date,
	niveau_qualification int not null REFERENCES niveau_qualification(id),
	entreprise int not null REFERENCES entreprise(id)
);


CREATE TABLE detail_offre_emploi 
(
	offre_emploi int not null REFERENCES offre_emploi(id),
	secteur_activite int not null REFERENCES secteur_activite(id),
	primary key(offre_emploi,secteur_activite)
);


CREATE TABLE message_offre_demploi 
(
	id serial primary key,
	dateEnvoi date,
	corpsMessage text,
	offre_emploi int not null REFERENCES offre_emploi(id),
	candidature int not null REFERENCES candidature(id)
);


CREATE TABLE message_candidature 
(
	id serial primary key,
	dateEnvoi date,
	corpsMessage text,
	candidature int not null REFERENCES candidature(id),
	offre_emploi int not null REFERENCES offre_emploi(id)
);

-- +----------------------------------------------------------------------------------------------+
-- | Insertion de quelques données de pour les tests                                              |
-- +----------------------------------------------------------------------------------------------+

-- Insertion des secteurs d'activité

insert into entreprise values (nextval('entreprise_id_seq'),'IMT Atlantique','IMT Atlantique est une grande école pionnière en formation, en recherche et en entrepreneuriat et en tout plein de choses...','Plouzané');
insert into entreprise values (nextval('entreprise_id_seq'),'ENIB','Une école d''ingénieur juste à côté...','Plouzané');

insert into niveau_qualification values (nextval('niveau_qualification_id_seq'), 'CAP/BEP');
insert into niveau_qualification values (nextval('niveau_qualification_id_seq'), 'Bac');
insert into niveau_qualification values (nextval('niveau_qualification_id_seq'), 'BAC+3');
insert into niveau_qualification values (nextval('niveau_qualification_id_seq'), 'BAC+5');
insert into niveau_qualification values (nextval('niveau_qualification_id_seq'), 'Dotorat');

insert into secteur_activite values (nextval('secteur_activite_id_seq'), 'Achats/Logistique');
insert into secteur_activite values (nextval('secteur_activite_id_seq'), 'Agriculture');
insert into secteur_activite values (nextval('secteur_activite_id_seq'), 'Assurance');
insert into secteur_activite values (nextval('secteur_activite_id_seq'), 'BTP/Immobilier');
insert into secteur_activite values (nextval('secteur_activite_id_seq'), 'Communication/Art/Média/Mode');
insert into secteur_activite values (nextval('secteur_activite_id_seq'), 'Direction Générale/Executive');
insert into secteur_activite values (nextval('secteur_activite_id_seq'), 'Electronique/Microélectronique');
insert into secteur_activite values (nextval('secteur_activite_id_seq'), 'Finance/Banque');
insert into secteur_activite values (nextval('secteur_activite_id_seq'), 'Hôtellerie/Restauration/Tourisme');
insert into secteur_activite values (nextval('secteur_activite_id_seq'), 'Informatique');
insert into secteur_activite values (nextval('secteur_activite_id_seq'), 'Marketing');
insert into secteur_activite values (nextval('secteur_activite_id_seq'), 'Ressources Humaines');
insert into secteur_activite values (nextval('secteur_activite_id_seq'), 'Télécom/Réseaux');
insert into secteur_activite values (nextval('secteur_activite_id_seq'), 'Assistanat/Secrétariat');
insert into secteur_activite values (nextval('secteur_activite_id_seq'), 'Agroalimentaire');
insert into secteur_activite values (nextval('secteur_activite_id_seq'), 'Audit/Conseil/Expertises');
insert into secteur_activite values (nextval('secteur_activite_id_seq'), 'Commercial');
insert into secteur_activite values (nextval('secteur_activite_id_seq'), 'Comptabilité');
insert into secteur_activite values (nextval('secteur_activite_id_seq'), 'Disitribution/Commerce');
insert into secteur_activite values (nextval('secteur_activite_id_seq'), 'Environnement');
insert into secteur_activite values (nextval('secteur_activite_id_seq'), 'Formation/Enseignement');
insert into secteur_activite values (nextval('secteur_activite_id_seq'), 'Industrie/Ingénierie/Production');
insert into secteur_activite values (nextval('secteur_activite_id_seq'), 'Juridique/Fiscal/Droit');
insert into secteur_activite values (nextval('secteur_activite_id_seq'), 'Public/Parapublic');
insert into secteur_activite values (nextval('secteur_activite_id_seq'), 'Santé/Social/Biologie/Humanitaire');

insert into candidature values (nextval('candidature_id_seq'), 'Hallyday', 'Johny', '01/01/2001', '102 rue de Paris', 'johny@halyday.com', 'Carrière Musicale dans le rockNroll', '27/01/2021', '1');
insert into candidature values (nextval('candidature_id_seq'), 'Paradis', 'Vanessa', '01/01/2008', '102 rue de Marseille', 'vanessa@paradis.com', 'Carrière Musicale dans la variéte française', '27/01/2021', '2');

insert into detail_candidature values ('1','1');
insert into detail_candidature values ('2','1');

insert into offre_emploi values (nextval('offre_emploi_id_seq'), 'poste chez facebook', 'Taches informatiques', 'developpeur', '01/01/2021','1','1');
insert into offre_emploi values (nextval('offre_emploi_id_seq'), 'poste chez twitter', 'Taches reseaux', 'pentesteur', '01/01/2021','1','2');

insert into detail_offre_emploi values ('1','1');
insert into detail_offre_emploi values ('2','2');

insert into message_offre_demploi values (nextval('message_offre_demploi_id_seq'),'01/01/2021','Bonjour vous nous interessez. Voulez vous nous rejoindre?', '1', '2');
insert into message_offre_demploi values (nextval('message_offre_demploi_id_seq'),'01/01/1999','Bonjour vous nous interessez. Voulez vous travailler avec nous?', '1', '2');

insert into message_candidature values (nextval('message_candidature_id_seq'), '02/01/2000', 'Bonjour, jai un bon profil et jai besoin dargent prenez moi svp', '2','2');
insert into message_candidature values (nextval('message_candidature_id_seq'), '02/01/2000', 'Votre offre minteresse, etes vous dispo pour un rdv', '1','2');
