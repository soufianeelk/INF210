package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.OffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.NiveauQualificationDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.OffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreDemploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification;
import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite;

/**
 * Session Bean implementation class ServiceOffreEmploi
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class ServiceOffreEmploi implements IServiceOffreEmploi
{
  //-----------------------------------------------------------------------------
  @EJB private OffreEmploiDAO candidatureDAO;
  @EJB private OffreEmploiDAO offreEmploiDAO;
  @EJB private NiveauQualificationDAO niveauQualificationDAO;
  //-----------------------------------------------------------------------------
  /**
   * Default constructor.
   */
  public ServiceOffreEmploi()
  {
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  @Override
  public OffreEmploi obtenirOffreEmploi(int id)
  {
    return candidatureDAO.findById(id);
  }
  //-----------------------------------------------------------------------------
  @Override
  public List<OffreEmploi> listeDesOffreEmplois()
  {
    return candidatureDAO.findAll();
  }
  //-----------------------------------------------------------------------------
  
  @Override
  public  List<MessageOffreDemploi> listeDesOffresPourUneEntreprise(int idEntreprise) {
  }
  
  @Override
  public List<MessageOffreDemploi> listeDesOffresPourUneCandidature(int idCandidature){
  }
  
  @Override
  public List<MessageOffreEmploi> listeDesMessagesEnvoyes(int idOffreEmploi){
	  List<MessageOffreEmploi> messagesEnvoyes = new ArrayList<>();
	  OffreEmploi candidature = candidatureDAO.findById(idOffreEmploi);
	  for(MessageOffreEmploi message: candidature.getMessageOffreEmplois()) {
		  messagesEnvoyes.add(message);
	  }
	  
	  return messagesEnvoyes;
  }
  
  @Override
  public OffreEmploi nouvelleOffreEmploi(String adresseMail, String adressePostale, String cv, String nom, String prenom, int idNQualification, List<SecteurActivite> secteursActivites) {
	  OffreEmploi candidature = new OffreEmploi();
	  candidature.setAdresseemail(adresseMail);
	  candidature.setAdressepostale(adressePostale);
	  candidature.setCv(cv);
	  candidature.setNom(nom);
	  candidature.setPrenom(prenom);
	  candidature.setNiveauQualificationBean(niveauQualificationDAO.findById(idNQualification));
	  candidature.setSecteurActivites(new HashSet<SecteurActivite>());
	  for(SecteurActivite sA: secteursActivites) {
		  candidature.addSecteurActivite(sA);
	  }
	  return(candidatureDAO.persist(candidature));
  }
  
  @Override
  public OffreEmploi miseAJourOffreEmploi(int id, String adresseMail, String adressePostale, String cv, String nom, String prenom, int idNQualification, List<SecteurActivite> secteursActivites) {
	  OffreEmploi candidature = candidatureDAO.findById(id);
	  candidature.setAdresseemail(adresseMail);
	  candidature.setAdressepostale(adressePostale);
	  candidature.setCv(cv);
	  candidature.setNom(nom);
	  candidature.setPrenom(prenom);
	  
	  for(NiveauQualification nQ: niveauQualificationDAO.findAll()){
		  for(OffreEmploi c: nQ.getOffreEmplois()) {
			if(c == candidature) {
				nQ.getOffreEmplois().remove(c);
			}
		  }
	  }
	  
	  candidature.setNiveauQualificationBean(niveauQualificationDAO.findById(idNQualification));
	  return(candidatureDAO.update(candidature));
  }
  
  @Override
  public void effaceOffreEmploi(int id) {
	  OffreEmploi candidature = new OffreEmploi();
	  candidature.setId(id);
	  candidatureDAO.remove(candidature);
  }
  
}
