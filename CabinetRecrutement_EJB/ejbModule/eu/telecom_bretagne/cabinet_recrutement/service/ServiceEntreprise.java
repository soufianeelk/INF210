package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.jws.WebService;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.EntrepriseDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.OffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreDemploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;

/**
 * Session Bean implementation class ServiceEntreprise
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class ServiceEntreprise implements IServiceEntreprise
{
  //-----------------------------------------------------------------------------
  @EJB private EntrepriseDAO entrepriseDAO;
  @EJB private OffreEmploiDAO offreEmploiDAO;
  //-----------------------------------------------------------------------------
  /**
   * Default constructor.
   */
  public ServiceEntreprise()
  {
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  @Override
  public Entreprise obtenirEntreprise(int id)
  {
    return entrepriseDAO.findById(id);
  }
  //-----------------------------------------------------------------------------
  @Override
  public List<Entreprise> listeDesEntreprises()
  {
    return entrepriseDAO.findAll();
  }
  //-----------------------------------------------------------------------------
  
  @Override
  public  List<MessageCandidature> listeDesMessagesRecus(int idEntreprise){
	  List<OffreEmploi> offresEmploi = new ArrayList<>();  
	  offresEmploi = offreEmploiDAO.findByEntreprise(idEntreprise);
	  List<MessageCandidature> messagesRecus = new ArrayList<>();
	  for(OffreEmploi offreEmploi: offresEmploi) {
		  
		  for(MessageCandidature message: offreEmploi.getMessageCandidatures()) {
			  messagesRecus.add(message);
		  }
	  }
	  
	  return messagesRecus;
  }
  
  @Override
  public List<MessageOffreDemploi> listeDesMessagesEnvoyes(int idEntreprise){
	  List<OffreEmploi> offresEmploi = new ArrayList<>();  
	  offresEmploi = offreEmploiDAO.findByEntreprise(idEntreprise);
	  List<MessageOffreDemploi> messagesEnvoyes = new ArrayList<>();
	  for(OffreEmploi offreEmploi: offresEmploi) {
		  
		  for(MessageOffreDemploi message: offreEmploi.getMessageOffreDemplois()) {
			  messagesEnvoyes.add(message);
		  }
	  }
	  
	  return messagesEnvoyes;
  }
  
  public Entreprise nouvelleEntreprise(String nom, String adressePostale, String descriptif) {
	  Entreprise entreprise = new Entreprise();
	  entreprise.setNom(nom);
	  entreprise.setAdressePostale(adressePostale);
	  entreprise.setDescriptif(descriptif);
	  entrepriseDAO.persist(entreprise);
	  return entreprise;
	  //return(entrepriseDAO.persist(entreprise));
  }
  
  public Entreprise miseAJourEntreprise(int id, String nom, String adressePostale, String descriptif) {
	  Entreprise entreprise = new Entreprise();
	  entreprise.setId(id);
	  entreprise.setNom(nom);
	  entreprise.setAdressePostale(adressePostale);
	  entreprise.setDescriptif(descriptif);
	  return(entrepriseDAO.update(entreprise));
  }
  
  public void effaceEntreprise(int id) {
	  Entreprise entreprise = new Entreprise();
	  entreprise.setId(id);
	  entrepriseDAO.remove(entreprise);
  }
}
