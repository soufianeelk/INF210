package eu.telecom_bretagne.cabinet_recrutement.service;

import java.time.LocalDateTime;
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
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreDemploi;
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
  public  List<MessageOffreDemploi> listeDesMessagesRecus(int idCandidature){
	  List<MessageOffreDemploi> messagesRecus = new ArrayList<>();
	  Candidature candidature = candidatureDAO.findById(idCandidature);
	  for(MessageOffreDemploi message: candidature.getMessageOffreDemplois()) {
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
  public Candidature nouvelleCandidature(String adresseMail, String adressePostale, String cv, String nom, String prenom, Date dateNaissance, int idNQualification, List<SecteurActivite> secteursActivites) {
	  Candidature candidature = new Candidature();
	  candidature.setAdresseemail(adresseMail);
	  candidature.setAdressepostale(adressePostale);
	  candidature.setCv(cv);
	  candidature.setNom(nom);
	  candidature.setPrenom(prenom);
	  candidature.setDatedepot(new Date());
	  candidature.setDatenaissance(dateNaissance);
	  niveauQualificationDAO.update(candidature.setNiveauQualificationBean(niveauQualificationDAO.findById(idNQualification)));
	  candidature.setSecteurActivites(new HashSet<SecteurActivite>());
	  for(SecteurActivite sA: secteursActivites) {
		  secteurActiviteDAO.update(candidature.addSecteurActivite(sA));
	  }
	  return(candidatureDAO.persist(candidature));
  }
  
  @Override
  public Candidature miseAJourCandidature(int id, String adresseMail, String adressePostale, String cv, String nom, String prenom, Date dateNaissance, int idNQualification, List<SecteurActivite> secteursActivites) {
	  Candidature candidature = candidatureDAO.findById(id);
	  candidature.setAdresseemail(adresseMail);
	  candidature.setAdressepostale(adressePostale);
	  candidature.setCv(cv);
	  candidature.setNom(nom);
	  candidature.setPrenom(prenom);
	  candidature.setDatenaissance(dateNaissance);
	  
	  //Pas mieux de faire ça ? :
	  
	  
	  for(NiveauQualification nQ: niveauQualificationDAO.findAll()){
		  for(Candidature c: nQ.getCandidatures()) {
			if(c == candidature) {
				nQ.getCandidatures().remove(c);
			}
		  }
		  niveauQualificationDAO.update(nQ);
	  }
	  
	  niveauQualificationDAO.update(candidature.setNiveauQualificationBean(niveauQualificationDAO.findById(idNQualification)));
	  
	  for(SecteurActivite sA: secteurActiviteDAO.findAll()) {
		  for(Candidature c: sA.getCandidatures()) {
			  if(c==candidature) {
				  sA.getCandidatures().remove(c);
			  }
			  secteurActiviteDAO.update(sA);
		  }
	  }
	  candidature.setSecteurActivites(new HashSet<SecteurActivite>());
	  for(SecteurActivite sA: secteursActivites) {
		  secteurActiviteDAO.update(candidature.addSecteurActivite(sA));
	  }
	  return(candidatureDAO.update(candidature));
  }
  
  @Override
  public void effaceCandidature(int id) {

  }
  
}
