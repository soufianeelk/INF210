package eu.telecom_bretagne.cabinet_recrutement.front.controlesDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.*;
import java.util.HashSet;
import eu.telecom_bretagne.cabinet_recrutement.data.model.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.EntrepriseDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise;
import eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator;
import eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocatorException;
import java.util.Set;
/**
 * Servlet implementation class TestServlet
 */
@WebServlet("/ControlesDAO")
public class ControlesDAOServlet extends HttpServlet
{
  //-----------------------------------------------------------------------------
  private static final long serialVersionUID = 1L;
  //-----------------------------------------------------------------------------
  /**
   * @see HttpServlet#HttpServlet()
   */
  public ControlesDAOServlet()
  {
    super();
  }
  //-----------------------------------------------------------------------------
  /**
   * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
   */
  protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
    // Flot de sortie pour écriture des résultats.
    PrintWriter out = response.getWriter();
    
    // Récupération de la référence vers le(s) DAO(s)
    EntrepriseDAO entrepriseDAO = null;
    CandidatureDAO candidatureDAO = null;
    NiveauQualificationDAO niveauQualificationDAO = null;
    OffreEmploiDAO offreEmploiDAO = null;
    SecteurActiviteDAO secteurActiviteDAO=null;
    MessageOffreDemploiDAO messageOffreDemploiDAO=null;
    MessageCandidatureDAO messageCandidatureDAO=null;

    try
    {
      entrepriseDAO = (EntrepriseDAO) ServicesLocator.getInstance().getRemoteInterface("EntrepriseDAO");
      candidatureDAO = (CandidatureDAO) ServicesLocator.getInstance().getRemoteInterface("CandidatureDAO");
      niveauQualificationDAO = (NiveauQualificationDAO) ServicesLocator.getInstance().getRemoteInterface("NiveauQualificationDAO");
      offreEmploiDAO = (OffreEmploiDAO) ServicesLocator.getInstance().getRemoteInterface("OffreEmploiDAO");
      secteurActiviteDAO = (SecteurActiviteDAO) ServicesLocator.getInstance().getRemoteInterface("SecteurActiviteDAO");
      messageOffreDemploiDAO = (MessageOffreDemploiDAO) ServicesLocator.getInstance().getRemoteInterface("MessageOffreDemploiDAO");
      messageCandidatureDAO = (MessageCandidatureDAO) ServicesLocator.getInstance().getRemoteInterface("MessageCandidatureDAO");
    }
    catch (ServicesLocatorException e)
    {
      e.printStackTrace();
    }
    out.println("Contrôles de fonctionnement du DAO EntrepriseDAO");
    out.println();
    
    // Contrôle(s) de fonctionnalités.
    
    //TESTS RAPIDES
    out.println();
    out.println("Afficher Entreprises");
    for(Entreprise e: entrepriseDAO.findAll()) {
    	out.println("Id: " + e.getId());
    	out.println("Nom: " + e.getNom());
    }
    out.println();
    out.println("Création Entreprise");
    Entreprise e1 = new Entreprise();
    entrepriseDAO.persist(e1);
    out.println("Entreprise créée:");
    out.println("Nom: "+e1.getNom());
    e1 = entrepriseDAO.findById(1);
    out.println("Entreprise id 1");
    out.println("Id: " + e1.getId());
    out.println("Nom: " + e1.getNom());
    e1.setNom("UPDATE OK");
    entrepriseDAO.update(e1);
    out.println("Entreprise modifiée");
    out.println("Nom: "+e1.getNom());
    

    
    out.println();
    out.println();
    out.println("Afficher Niveaux Qualifications");
    for(NiveauQualification nQ: niveauQualificationDAO.findAll()) {
    	out.println("Id: " + nQ.getId());
    	out.println("Nom: " + nQ.getIntitule());
    }
    out.println();
    out.println("Creation NiveauQualification");
    NiveauQualification nQ = new NiveauQualification();
    niveauQualificationDAO.persist(nQ);
    out.println("Nom: " + nQ.getIntitule());
    nQ = niveauQualificationDAO.findById(1);
    out.println("NiveauQualification d'id 1:");
    out.println("Id: " + nQ.getId());
	out.println("Nom: " + nQ.getIntitule());
    nQ.setIntitule("UPDATE OK");
    niveauQualificationDAO.update(nQ);
    out.println("NiveauQualification modifié");
    out.println("Nom: " + nQ.getIntitule());

	
	out.println();
    out.println();
    out.println("Afficher Secteurs Activites");
    for(SecteurActivite sA: secteurActiviteDAO.findAll()) {
    	out.println("Id: " + sA.getId());
    	out.println("Nom: " + sA.getIntitule());
    }
    out.println();
    out.println("Création SecteurActivite");
    SecteurActivite sA = new SecteurActivite();
    secteurActiviteDAO.persist(sA);
	out.println("Nom: " + sA.getIntitule());
    out.println("NiveauQualification d'id 1:");
    sA = secteurActiviteDAO.findById(1);
    out.println("Id: " + sA.getId());
	out.println("Nom: " + sA.getIntitule());
    sA.setIntitule("UPDATE OK");
    secteurActiviteDAO.update(sA);
    out.println("SecteurActivite modifié");
    out.println("Nom: " + sA.getIntitule());

	
	out.println();
	out.println();
	out.println("Afficher Offres Emploi");
    for(OffreEmploi oE: offreEmploiDAO.findAll()) {
    	out.println("Id: " + oE.getId());
    	out.println("Nom: " + oE.getTitre());
    }
    
    out.println();
    out.println("Création OffreEmploi");
    OffreEmploi oE = new OffreEmploi();
    oE.setEntrepriseBean(e1);
    oE.setNiveauQualificationBean(nQ);
    oE.setSecteurActivites(new HashSet<SecteurActivite>());
    oE.addSecteurActivite(sA);
    offreEmploiDAO.persist(oE);
    out.println("Titre: " + oE.getTitre());
    out.println("Entreprise associée: " + oE.getEntrepriseBean().getNom());
    out.println("Niveau Qualification: " + oE.getNiveauQualificationBean());
    out.println("Secteurs:");
    for(SecteurActivite sAC: oE.getSecteurActivites()) {
    	out.println("Id: " + sAC.getId());
    	out.println(sAC.getIntitule());
    }
    out.println();
    out.println("OffreEmploi d'id 1");
    offreEmploiDAO.findById(1);
    out.println("Id: " + oE.getId());
    out.println("Titre: " + oE.getTitre());
    out.println("Entreprise associée: " + oE.getEntrepriseBean().getNom());
    out.println("Niveau Qualification: " + oE.getNiveauQualificationBean());
    oE.setTitre("UPDATE OK");
    offreEmploiDAO.update(oE);
    out.println("OffreEmploi modifiée:");
    out.println("Id: " + oE.getId());
    out.println("Titre: " + oE.getTitre());
    out.println("Entreprise associée: " + oE.getEntrepriseBean().getNom());
    out.println("Niveau Qualification: " + oE.getNiveauQualificationBean());
    offreEmploiDAO.remove(oE); 
    out.println("Suprresion de l'offre Emploi id 1");
    out.println("Cherche les offres d'emploi de l'entreprise d'id 2:");
    for (OffreEmploi oEM: offreEmploiDAO.findByEntreprise(2)) {
    	out.println("Id: " + oEM.getId());
        out.println("Titre: " + oE.getTitre());
        out.println("Entreprise associée: " + oE.getEntrepriseBean().getNom());
        out.println("Niveau Qualification: " + oE.getNiveauQualificationBean());
    }
    out.println("Cherche les offres d''emploi de secteur et qualifiation d''ids 1");
    for (OffreEmploi oEM: offreEmploiDAO.findBySecteurActiviteAndNiveauQualification(1, 1)) {
    	out.println("Id: " + oEM.getId());
        out.println("Titre: " + oE.getTitre());
        out.println("Entreprise associée: " + oE.getEntrepriseBean().getNom());
        out.println("Niveau Qualification: " + oE.getNiveauQualificationBean());
    }
    
    candidatureDAO.findAll();
    Candidature c = new Candidature();
    c.setId(100);
    c.setNiveauQualificationBean(nQ);
    c.setSecteurActivites(new HashSet<SecteurActivite>());
    c.addSecteurActivite(sA);
    candidatureDAO.persist(c);
    c.setNom("UPDATE OK");
    candidatureDAO.update(c);
    candidatureDAO.remove(c);
    candidatureDAO.findById(1);
    candidatureDAO.findBySecteurActiviteAndNiveauQualification(1, 1);
    
   /* messageCandidatureDAO.findAll();
    MessageCandidature mC = new MessageCandidature();
    mC.setId(100);
    mC.setCandidatureBean(c);
    mC.setOffreEmploiBean(oE);
    messageCandidatureDAO.persist(mC);
    mC.setCorpsmessage("UPDATE OK");
    messageCandidatureDAO.update(mC);
    messageCandidatureDAO.remove(mC);
    messageCandidatureDAO.findById(1);
    
    messageOffreDemploiDAO.findAll();
    MessageOffreDemploi mOE = new MessageOffreDemploi();
    mOE.setId(100);
    mOE.setOffreEmploiBean(oE);
    mOE.setCandidatureBean(c);;
    messageOffreDemploiDAO.persist(mOE);
    mOE.setCorpsmessage("UPDATE OK");
    messageOffreDemploiDAO.update(mOE);
    messageOffreDemploiDAO.remove(mOE);
    messageOffreDemploiDAO.findById(1);
    
    entrepriseDAO.remove(e1);
    
    
    //---------------------------------------------------------------------------------------------------------//
    
   /* out.println("Liste des entreprises :");
    List<Entreprise> entreprises = entrepriseDAO.findAll();
    
    for(Entreprise entreprise : entreprises)
    {
      out.println(entreprise.getNom());
    }
    out.println();
    
    out.println("Obtention de l'entreprise n° 1 :");
    Entreprise e = entrepriseDAO.findById(1);
    out.println(e.getId());
    out.println(e.getNom());
    out.println(e.getDescriptif());
    out.println(e.getAdressePostale());
    out.println(e.getOffreEmplois());
    out.println();

    out.println("Obtention de l'entreprise n° 2 :");
    e = entrepriseDAO.findById(2);
    out.println(e.getId());
    out.println(e.getNom());
    out.println(e.getDescriptif());
    out.println(e.getAdressePostale());
    out.println();
    
    out.println("############################################################################");
 
    
 // TEST LIVRABLE  PARTIE 2 
    
    out.println();
    out.println("TEST LIVRABLE PARTIE 2");
    out.println();
    out.println();
    
    //CREATION ENTREPRISE
    out.println();
    out.println("---Création Entreprise---");
   Entreprise entreprise = new Entreprise();
    entreprise.setNom("Ericsson");
    entreprise.setAdressePostale("Rue de Lannion");
    entreprise.setDescriptif("Telecoms");
    entreprise.setOffreEmplois(new HashSet<OffreEmploi>());
    entrepriseDAO.persist(entreprise);
    out.println("---Entreprise créée---");
    
    //Affichage
    out.println(entreprise.getId());
    out.println(entreprise.getNom());
    entreprise.getAdressePostale();
    entreprise.getDescriptif();
    out.println("OffresEmploi associées:");
    
    for(OffreEmploi oE: entreprise.getOffreEmplois()) {
    	out.println(oE.getId());
    	out.println(oE.getTitre());
    }
    
   
    //CREATION SECTEUR ACTIVITE
    out.println();
    out.println("---Creation SecteurActivite 1---");
    SecteurActivite secteurActivite = new SecteurActivite();
    secteurActivite.setIntitule("Telecommunications");
    secteurActivite.setCandidatures(new HashSet<Candidature>());
    secteurActivite.setOffreEmplois(new HashSet<OffreEmploi>());
    secteurActiviteDAO.persist(secteurActivite);
    out.println("---SecteurActivite 1 créé---");
    
    //Affichage
    out.println(secteurActivite.getId());
    out.println(secteurActivite.getIntitule());
    out.println(secteurActivite.getCandidatures());
    out.println("Candidatures associées:");
    for(Candidature c: secteurActivite.getCandidatures()) {
    	out.println(c.getId());
    	out.println(c.getNom()+" "+c.getPrenom());
    }
    
    out.println(secteurActivite.getOffreEmplois());
    out.println("Offres Emploi associées");
    for(OffreEmploi oE: secteurActivite.getOffreEmplois()) {
    	out.println(oE.getId());
    	out.println(oE.getTitre());
    	out.println(oE.getEntrepriseBean());
    }
    
    out.println();
    out.println("---Creation SecteurActivite 2---");
    SecteurActivite secteurActivite2 = new SecteurActivite();
    secteurActivite2.setIntitule("Develeoppement");
    secteurActivite2.setCandidatures(new HashSet<Candidature>());
    secteurActivite2.setOffreEmplois(new HashSet<OffreEmploi>());
    secteurActiviteDAO.persist(secteurActivite2);
    out.println("---SecteurActivite 2 créé---");
    
    //Affichage
    out.println(secteurActivite2.getId());
    out.println(secteurActivite2.getIntitule());
    out.println(secteurActivite2.getCandidatures());
    out.println("Candidatures associées:");
    for(Candidature c: secteurActivite2.getCandidatures()) {
    	out.println(c.getId());
    	out.println(c.getNom()+" "+c.getPrenom());
    }
    out.println(secteurActivite2.getOffreEmplois());
    out.println("Offres Emploi associées");
    for(OffreEmploi oE: secteurActivite2.getOffreEmplois()) {
    	out.println(oE.getId());
    	out.println(oE.getTitre());
    	out.println(oE.getEntrepriseBean());
    }
    
    //CREATION NIVEAU QUALIFICATION
    out.println();
    out.println("---Creation NiveauQualification---");
    NiveauQualification niveauQualification = new NiveauQualification();
    niveauQualification.setIntitule("BAC+12");
    niveauQualification.setCandidatures(new HashSet<Candidature>());
    niveauQualification.setOffreEmplois(new HashSet<OffreEmploi>());
    niveauQualificationDAO.persist(niveauQualification);
    out.println("---NiveauQualification créé---");
    
    //Affichage
    out.println(niveauQualification.getId());
    out.println(niveauQualification.getIntitule());
    out.println(niveauQualification.getCandidatures());
    out.println("Candidatures associées");
    for(Candidature c: niveauQualification.getCandidatures()) {
    	out.println(c.getId());
    	out.println(c.getNom()+" "+c.getPrenom());
    }
    
    out.println(niveauQualification.getOffreEmplois());
    out.println("Offres Emplois associées");
    for(OffreEmploi oE: niveauQualification.getOffreEmplois()) {
    	out.println(oE.getId());
    	out.println(oE.getTitre());
    	out.println(oE.getEntrepriseBean());
    }
    
    
   
    //CREATION OFFRE EMPLOI
    out.println();
    out.println("---Creation OffreEmploi---");
    OffreEmploi offreEmploi= new OffreEmploi();
    offreEmploi.setTitre("Offre Emloi à temps partiel");
    offreEmploi.setDatedepot(new Date(2021, 02, 24));
    offreEmploi.setDescriptifmission("Mission rapide");
    offreEmploi.setEntrepriseBean(entrepriseDAO.findById(1));
    offreEmploi.setSecteurActivites(new HashSet<SecteurActivite>());
    offreEmploi.setMessageCandidatures(new HashSet<MessageCandidature>());
    offreEmploi.setMessageOffreDemplois(new HashSet<MessageOffreDemploi>());
    Entreprise oEEntreprise = entrepriseDAO.findById(1);
    offreEmploi.setEntrepriseBean(oEEntreprise);
    NiveauQualification oENQ = niveauQualificationDAO.findById(1);
    offreEmploi.setNiveauQualificationBean(oENQ);
    offreEmploi.setProfilrecherche("Volontaire et travailleur");
    SecteurActivite oESA1 = secteurActiviteDAO.findById(1);
    SecteurActivite oESA2 = secteurActiviteDAO.findById(2);
    offreEmploi.addSecteurActivite(oESA1);
    offreEmploi.addSecteurActivite(oESA2);
    niveauQualificationDAO.update(oENQ);
    secteurActiviteDAO.update(oESA1);
    secteurActiviteDAO.update(oESA2);
    offreEmploiDAO.persist(offreEmploi);
    out.println("---OffreEmploi créé---");
    
    //Affichage
    out.println(offreEmploi.getId());
    out.println(offreEmploi.getTitre());
    out.println(offreEmploi.getProfilrecherche());
    out.println(offreEmploi.getDatedepot());
    out.println(offreEmploi.getDescriptifmission());
    out.println(offreEmploi.getEntrepriseBean().getNom());
    
    //Affichage Entreprise modifié
    out.println("Affichage nouvelle liste d'offres emploi de l'entrepriseBean");
    out.println(offreEmploi.getEntrepriseBean().getOffreEmplois());
    for(OffreEmploi oE: offreEmploi.getEntrepriseBean().getOffreEmplois()) {
    	out.println(oE.getId());
    	out.println(oE.getTitre());
    	out.println(oE.getEntrepriseBean());
    }
    
    //Affichage SecteurActivites modifiés
    out.println("Affichage nouvelle liste d'offres emploi des secteur activités");
    for(SecteurActivite sA: offreEmploi.getSecteurActivites()) {
    	out.println(sA.getIntitule());
    	for(OffreEmploi oE: sA.getOffreEmplois()) {
    		out.println(offreEmploi.getId());
    		out.println(oE.getTitre());
        	out.println(oE.getEntrepriseBean());
    	}
    }
    
    
    //CREATION CANDIDATURE
    out.println();
    out.println("---Creation Candidature---");
    Candidature candidature = new Candidature();
    candidature.setAdresseemail("adresse@mail.fr");
    candidature.setAdressepostale("Rue pole emploi");
    candidature.setCv("Mec sérieux et travailleur");
    candidature.setDatedepot(new Date(2021, 02, 25));
    candidature.setDatenaissance(new Date(2000, 01, 01));
    candidature.setSecteurActivites(new HashSet<SecteurActivite>());
    candidature.setMessageCandidatures(new HashSet<MessageCandidature>());
    candidature.setMessageOffreDemplois(new HashSet<MessageOffreDemploi>());
    NiveauQualification nQC = niveauQualificationDAO.findById(1);
    candidature.setNiveauQualificationBean(nQC);
    candidature.setNom("Chomage");
    candidature.setPrenom("Jean");
    SecteurActivite cSA1 = secteurActiviteDAO.findById(1);
    SecteurActivite cSA2 = secteurActiviteDAO.findById(2);
    candidature.addSecteurActivite(cSA1);
    candidature.addSecteurActivite(cSA2);
    niveauQualificationDAO.update(nQC);
    secteurActiviteDAO.update(cSA1);
    secteurActiviteDAO.update(cSA2);
    candidatureDAO.persist(candidature);
    
    //CREATION MESSAGE OFFRE EMPLOI
    out.println();
    out.println("---Creation Offre Emploi---");
    
    //CREATION MESSAGE CANDIDATURE
   
  
    /*out.println("--- Test de recherche de candidature avec secteur d'activité et niveau de qualification spécifique (ID=1/ID=2) ");
    out.println();
    
    List<Candidature> c=candidatureDAO.findBySecteurActiviteAndNiveauQualification(1, 2);
    for (Candidature candidature : c) {
    out.println(candidature.getId());
    out.println(candidature.getNom());
    out.println(candidature.getPrenom());
    out.println(candidature.getDatenaissance());
    out.println(candidature.getAdressepostale());
    out.println(candidature.getAdresseemail());
    out.println(candidature.getCv());
    out.println(candidature.getDatedepot());
    out.println(candidature.getNiveauQualificationBean());
    out.println();
    }
    
    // OffreEmploiDAO
   
    out.println();
    out.println("--- Test de recherche d'offre d'emploi par l'identifiant d'entreprise (ID=1) :");
    out.println();
    
    List<OffreEmploi> o=offreEmploiDAO.findByEntreprise(1);
    for (OffreEmploi offreemploi : o) {
    out.println(offreemploi.getId());
    out.println(offreemploi.getTitre());
    out.println(offreemploi.getDescriptifmission());
    out.println(offreemploi.getProfilrecherche());
    out.println(offreemploi.getDatedepot());
    out.println(offreemploi.getNiveauQualificationBean());
    out.println(offreemploi.getEntrepriseBean());
    out.println();
    }
   
    out.println();
    out.println("--- Test de recherche d'offre d'emploi par secteur d'activité = 1 et Niveau de Qualification = 1");
    out.println();
    o=offreemploiDAO.findBySecteurActiviteAndNiveauQualification(1, 1);
    for (OffreEmploi offreemploi : o) {
    out.println(offreemploi.getId());
    out.println(offreemploi.getTitre());
    out.println(offreemploi.getDescriptifmission());
    out.println(offreemploi.getProfilrecherche());
    out.println(offreemploi.getDatedepot());
    out.println(offreemploi.getNiveauQualificationBean());
    out.println(offreemploi.getEntrepriseBean());
    out.println();
    }
    out.println();
    out.println("--- Test de création et persistence d'une nouvelle offre d'emploi. Affichage de l'ensemble des offres d'emplois (test OffreEmploiDAO)");
    
    
    */
    /*out.println();
    OffreEmploi n= new OffreEmploi();
    n.setId(3);
    n.setTitre("Offre d'emploi n°3");
    n.setDescriptifmission("Descriptif Offre d'emploi n°3");
    n.setProfilrecherche("Profil recherché pour emploi n°3");
    n.setDatedepot(new Date(4,2,2021));
    n.setNiveauQualificationBean(niveauQualificationDAO.findById(2));
    n.setEntrepriseBean(e);
    offreEmploiDAO.persist(n);
    
    List<OffreEmploi> offres =offreemploiDAO.findAll();
    
    for (OffreEmploi offre : offres) {
        out.println(offre.getId());
        out.println(offre.getTitre());
        out.println(offre.getDescriptifmission());
        out.println(offre.getProfilrecherche());
        out.println(offre.getDatedepot());
        out.println(offre.getNiveauQualificationBean());
        out.println(offre.getEntrepriseBean());
        out.println();
    }

    out.println();
    out.println("--- Modification de certains champs de l'offre d'emploi n°3. Affichage de l'offre d'emploi n°3");
    out.println();
    
    n.setTitre("Offre d'emploi n°3 (version 2)");
    n.setDescriptifmission("Descriptif Offre d'emploi n°3 (version 2)");
    n.setProfilrecherche("Profil recherché pour emploi n°3 (version 2)");
    n.setDatedepot(new Date(10,2,2021));
    offreemploiDAO.update(n);
    
    
    OffreEmploi uneoffre = offreemploiDAO.findById(3);
    
        out.println(uneoffre.getId());
        out.println(uneoffre.getTitre());
        out.println(uneoffre.getDescriptifmission());
        out.println(uneoffre.getProfilrecherche());
        out.println(uneoffre.getDatedepot());
        out.println(uneoffre.getNiveauQualificationBean());
        out.println(uneoffre.getEntrepriseBean());
        out.println();

    
    out.println();
    out.println("--- Suppression de l'offre d'emploi n°3. Affichage de l'ensemble des offres d'emplois (test OffreEmploiDAO)");
    out.println();
    
    offreemploiDAO.remove(n);
    
    offres =offreemploiDAO.findAll();
    
    for (OffreEmploi offre : offres) {
        out.println(offre.getId());
        out.println(offre.getTitre());
        out.println(offre.getDescriptifmission());
        out.println(offre.getProfilrecherche());
        out.println(offre.getDatedepot());
        out.println(offre.getNiveauQualificationBean());
        out.println(offre.getEntrepriseBean());
        out.println();
    }
        
        out.println();
        out.println("--- Création d'une nouvelle candidature. ");
        out.println();
        Candidature c2 = new Candidature();
        c2.setNom("Jordan (GOAT)");
        c2.setPrenom("Michael");
        c2.setDatenaissance(new Date(17,02,1963));
        c2.setAdressepostale("Chicago");
        c2.setAdresseemail("michaeljordan@bulls.com");
        c2.setCv("Basketteur retraité. Entrepreneur");
        c2.setDatedepot(new Date(2,2,2021));
        c2.setNiveauQualificationBean(niveauQualificationDAO.findById(2));
        Set<SecteurActivite> set=new HashSet<SecteurActivite>();
        c2.setSecteurActivites(set);
        c2.getSecteurActivites().add(secteurActiviteDAO.findById(2));
        c2.getSecteurActivites().add(secteurActiviteDAO.findById(1));
        candidatureDAO.persist(c2);

        c=candidatureDAO.findAll();
        for (Candidature candidature1 : c) {
        out.println(candidature1.getId());
        out.println(candidature1.getNom());
        out.println(candidature1.getPrenom());
        out.println(candidature1.getDatenaissance());
        out.println(candidature1.getAdressepostale());
        out.println(candidature1.getAdresseemail());
        out.println(candidature1.getCv());
        out.println(candidature1.getDatedepot());
        out.println(candidature1.getNiveauQualificationBean());
        out.println(candidature1.getSecteurActivites());
        out.println();
        }
        
      	out.println();
      	out.println("--- Vérification des candidatures par secteur d'activité.");
      	out.println();

        
        List<SecteurActivite> listeSecteursActivites = secteurActiviteDAO.findAll();
        
        for (SecteurActivite s : listeSecteursActivites) {
        	out.println(s.getId());
        	out.println(s.getIntitule());
        	out.println(s.getCandidatures());
            out.println();
        }
      	
        out.println();
        out.println("--- Affichage des messages d'offre d'emploi. ");
        out.println();
        
        List<MessageOffreDemploi> listeMessageOffreDemploi = messageOffreDemploiDAO.findAll();
        
        for (MessageOffreDemploi m : listeMessageOffreDemploi) {
        	out.println(m.getId());
        	out.println(m.getDateenvoi());
        	out.println(m.getCorpsmessage());
        	out.println(m.getOffreEmploiBean());
        	out.println(m.getCandidatureBean());
        }
        
        out.println();
        out.println("--- Affichage des messages de candidature. ");
        out.println();
        
        List<MessageCandidature> listeMessageCandidature = messageCandidatureDAO.findAll();
        
        for (MessageCandidature m : listeMessageCandidature) {
        	out.println(m.getId());
        	out.println(m.getDateenvoi());
        	out.println(m.getCorpsmessage());
        	out.println(m.getCandidatureBean());
        	out.println(m.getOffreEmploiBean());
        }*/

    }
  

  /*public static void main(String[] args) {  
	  /*System.out.println();
	  System.out.println("---Création Entreprise---");
	  
	  
	  EntrepriseDAO entrepriseDAO = new EntrepriseDAO();
	  entrepriseDAO.findById(1);
	  Entreprise entreprise = new Entreprise();
	  entreprise.setNom("Ericsson");
	  entreprise.setId(10);
	  entreprise.setAdressePostale("Rue de Lannion");
	  entreprise.setDescriptif("Telecoms");
	  entreprise.setOffreEmplois(new HashSet<OffreEmploi>());
	  entrepriseDAO.persist(entreprise);
	  
	  
	  
	  System.out.println();
	  System.out.println("---Creation SecteurActivite 1---");
	  SecteurActiviteDAO secteurActiviteDAO = new SecteurActiviteDAO();
	  SecteurActivite secteurActivite = new SecteurActivite();
	  secteurActivite.setIntitule("Telecommunications");
	  secteurActivite.setCandidatures(new HashSet<Candidature>());
	  secteurActivite.setOffreEmplois(new HashSet<OffreEmploi>());
	  SecteurActivite secteur = secteurActiviteDAO.findById(1);
	  System.out.println(secteur.getIntitule());
	  //secteurActiviteDAO.persist(secteurActivite);
  }*/
  
  }
