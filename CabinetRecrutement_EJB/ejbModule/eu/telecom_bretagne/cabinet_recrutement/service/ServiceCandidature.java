package eu.telecom_bretagne.cabinet_recrutement.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.CandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.NiveauQualificationDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.OffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.SecteurActiviteDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreDEmploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification;
import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite;

/**
 * Session Bean implementation class ServiceCandidature
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class ServiceCandidature implements IServiceCandidature
{
  //-----------------------------------------------------------------------------
  @EJB private CandidatureDAO candidatureDAO;
  @EJB private OffreEmploiDAO offreEmploiDAO;
  @EJB private NiveauQualificationDAO niveauQualificationDAO;
  @EJB private SecteurActiviteDAO secteurActiviteDAO;
  //-----------------------------------------------------------------------------
  /**
   * Default constructor.
   */
  public ServiceCandidature()
  {
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  @Override
  public Candidature obtenirCandidature(int id)
  {
    return candidatureDAO.findById(id);
  }
  //-----------------------------------------------------------------------------
  @Override
  public List<Candidature> listeDesCandidatures()
  {
    return candidatureDAO.findAll();
  }
  //-----------------------------------------------------------------------------
  
  @Override
  public List<Candidature> listeDesCandidaturesPourUneOffre(int idOffre) {
	  OffreEmploi offre = offreEmploiDAO.findById(idOffre);
	  List<Candidature> candidatures = new ArrayList<>();
	  for(MessageCandidature messageCandidature: offre.getMessageCandidatures()) {
		 candidatures.add(messageCandidature.getCandidatureBean());
	  }
	  return candidatures;
	  
  }
  
  @Override
  public  List<MessageOffreDEmploi> listeDesMessagesRecus(int idCandidature){
	  List<MessageOffreDEmploi> messagesRecus = new ArrayList<>();
	  Candidature candidature = candidatureDAO.findById(idCandidature);
	  for(MessageOffreDEmploi message: candidature.getMessageOffreDemplois()) {
		  messagesRecus.add(message);
	  }
	  
	  return messagesRecus;

  }
  
  @Override
  public List<MessageCandidature> listeDesMessagesEnvoyes(int idCandidature){
	  List<MessageCandidature> messagesEnvoyes = new ArrayList<>();
	  Candidature candidature = candidatureDAO.findById(idCandidature);
	  for(MessageCandidature message: candidature.getMessageCandidatures()) {
		  messagesEnvoyes.add(message);
	  }
	  return messagesEnvoyes;
  }
  
  @Override
  public Candidature nouvelleCandidature(String adresseMail, String adressePostale, String cv, String nom, String prenom, String dateNaissance, String nQualification, String[] idSecteursActivites) {
	  Candidature candidature = new Candidature();
	  candidature.setAdresseemail(adresseMail);
	  candidature.setAdressepostale(adressePostale);
	  //A supp
	  candidature.setCv(cv);
	  candidature.setNom(nom);
	  candidature.setPrenom(prenom);
	  candidature.setDatedepot(new Date());
	  try {
		  dateNaissance = dateNaissance.replaceAll("-", "/");
		  candidature.setDatenaissance(new SimpleDateFormat("dd/MM/yyyy").parse(dateNaissance));
	  } catch (java.text.ParseException e) {
		  e.printStackTrace();
	  }
	  
	  int idNQualification = Integer.parseInt(nQualification);
	  NiveauQualification nQ = niveauQualificationDAO.findById(idNQualification);
	  niveauQualificationDAO.update(candidature.setNiveauQualificationBean(nQ));
	  List<SecteurActivite> secteursActivites = new ArrayList<>();
	  
	  /*for(String idSQ: idSecteursActivites) {
		  secteursActivites.add(secteurActiviteDAO.findById(Integer.parseInt(idSQ)));
	  }*/
	  for(int i=0; i<idSecteursActivites.length; i++) {
		  int idSA = Integer.parseInt(idSecteursActivites[i]);
		  SecteurActivite sAC = secteurActiviteDAO.findById(idSA);
		  secteursActivites.add(sAC);
	  }
	  candidature.setSecteurActivites(new HashSet<SecteurActivite>());
	  for(SecteurActivite sA: secteursActivites) {
		  sA = candidature.addSecteurActivite(sA);
		  secteurActiviteDAO.update(sA);
	  }
	  
	  return(candidatureDAO.persist(candidature));
  }
  
  @Override
  public Candidature miseAJourCandidature(int id, String adresseMail, String adressePostale, String cv, String nom, String prenom, String dateNaissance, String nQualification, String[] idSecteursActivites) {
	  Candidature candidature = candidatureDAO.findById(id);
	  candidature.setAdresseemail(adresseMail);
	  candidature.setAdressepostale(adressePostale);
	  candidature.setCv(cv);
	  candidature.setNom(nom);
	  candidature.setPrenom(prenom);
	  try {
		  dateNaissance = dateNaissance.replaceAll("-", "/");
		  candidature.setDatenaissance(new SimpleDateFormat("dd/MM/yyyy").parse(dateNaissance));
	  } catch (java.text.ParseException e) {
		  e.printStackTrace();
	  }
	  
	  /*for(NiveauQualification nQ: niveauQualificationDAO.findAll()){
		  for(Candidature c: nQ.getCandidatures()) {
			if(c == candidature) {
				nQ.getCandidatures().remove(c);
			}
		  }
		  niveauQualificationDAO.update(nQ);
	  }*/
	  
	
	  int idNQualification = Integer.parseInt(nQualification);
	  
	  NiveauQualification nQBean = candidature.getNiveauQualificationBean();
	  nQBean.removeCandidature(candidature);
	  niveauQualificationDAO.update(candidature.getNiveauQualificationBean());
	  
	  niveauQualificationDAO.update(candidature.setNiveauQualificationBean(niveauQualificationDAO.findById(idNQualification)));
	  
	  for(SecteurActivite sA: candidature.getSecteurActivites()) {
		  sA.removeCandidature(candidature);
	  }
	  
	  candidature.setSecteurActivites(new HashSet<SecteurActivite>());
	  List<SecteurActivite> secteursActivites = new ArrayList<>();
	  for(String idSQ: idSecteursActivites) {
		  secteursActivites.add(secteurActiviteDAO.findById(Integer.parseInt(idSQ)));
	  }
	  for(SecteurActivite sA: secteursActivites) {
		  secteurActiviteDAO.update(candidature.addSecteurActivite(sA));
	  }
	  return(candidatureDAO.update(candidature));
  }
  
  @Override
  public HashSet<Candidature> findCandidatureByNiveauQualificationAndSecteurActivite(int idOffre) {
		
		OffreEmploi offre = offreEmploiDAO.findById(idOffre);
		int idNiveauQualification = offre.getNiveauQualificationBean().getId().intValue();
		HashSet<Candidature> listeCandidature = new HashSet<Candidature>();
		
		for (SecteurActivite sA : offre.getSecteurActivites()) {
			
			for (Candidature c : candidatureDAO.findBySecteurActiviteAndNiveauQualification(sA.getId().intValue(), idNiveauQualification)) {
				listeCandidature.add(c);
			}
			
		}
		
		return listeCandidature;
		
	}
  
  @Override
  public void effaceCandidature(int id) {

  }
  
  
  
}
