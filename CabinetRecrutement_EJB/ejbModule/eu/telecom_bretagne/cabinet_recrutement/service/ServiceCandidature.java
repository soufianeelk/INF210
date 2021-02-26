package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.jws.WebService;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.CandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.OffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreDemploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;

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
  
  public Candidature nouvelleCandidature(String adresseMail, String adressePostale, String cv, String nom, String prenom, int idNvQualifi) {
	  Candidature candidature = new Candidature();
	  candidature.setAdresseemail(adresseMail);
	  candidature.setAdressepostale(adressePostale);
	  candidature.setCv(cv);
	  candidature.setNom(nom);
	  candidature.setPrenom(prenom);
	  return(candidatureDAO.persist(candidature));
  }
  
  public Candidature miseAJourCandidature(int id, String adresseMail, String adressePostale, String cv, String nom, String prenom) {
	  Candidature candidature = new Candidature();
	  candidature.setId(id);
	  candidature.setAdresseemail(adresseMail);
	  candidature.setAdressepostale(adressePostale);
	  candidature.setCv(cv);
	  candidature.setNom(nom);
	  candidature.setPrenom(prenom);
	  return(candidatureDAO.update(candidature));
  }
  
  public void effaceCandidature(int id) {
	  Candidature candidature = new Candidature();
	  candidature.setId(id);
	  candidatureDAO.remove(candidature);
  }
}
