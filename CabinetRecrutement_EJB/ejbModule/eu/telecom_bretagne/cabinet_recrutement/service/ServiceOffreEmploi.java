package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.OffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.SecteurActiviteDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.CandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.EntrepriseDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.NiveauQualificationDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.OffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreDEmploi;
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
  @EJB private OffreEmploiDAO offreEmploiDAO;
  @EJB private EntrepriseDAO entrepriseDAO;
  @EJB private CandidatureDAO candidatureDAO;
  @EJB private NiveauQualificationDAO niveauQualificationDAO;
  @EJB private SecteurActiviteDAO secteurActiviteDAO;
  
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
    return offreEmploiDAO.findById(id);
  }
  //-----------------------------------------------------------------------------
  @Override
  public List<OffreEmploi> listeDesOffreEmplois()
  {
    return offreEmploiDAO.findAll();
  }
  //-----------------------------------------------------------------------------
  
  @Override
  public  List<OffreEmploi> listeDesOffresPourUneEntreprise(int idEntreprise) {
	  List<OffreEmploi> offresEmploi = new ArrayList<>(); 
	  for(OffreEmploi oE: entrepriseDAO.findById(idEntreprise).getOffreEmplois()) {
		  offresEmploi.add(oE);
	  }
	  return offresEmploi;
  }
  
  @Override
  public List<OffreEmploi> listeDesOffresPourUneCandidature(int idCandidature){
	  List<OffreEmploi> offresEmploi = new ArrayList<>(); 
	  for(MessageOffreDEmploi message: candidatureDAO.findById(idCandidature).getMessageOffreDemplois()) {
		  offresEmploi.add(message.getOffreEmploiBean());
	  }
	  return offresEmploi;
  }
  
  @Override
  public OffreEmploi nouvelleOffreEmploi(String descriptif, String profilRecherche, String titre, int idEntreprise, int idNQualification, List<Integer> idSecteursActivites) {
	  OffreEmploi offreEmploi = new OffreEmploi();
	  offreEmploi.setDatedepot(new Date());
	  offreEmploi.setTitre(titre);
	  offreEmploi.setDescriptifmission(descriptif);
	  offreEmploi.setProfilrecherche(profilRecherche);
	  offreEmploi.setEntrepriseBean(entrepriseDAO.findById(idEntreprise));
	  niveauQualificationDAO.update(offreEmploi.setNiveauQualificationBean(niveauQualificationDAO.findById(idNQualification)).get(1));
	  
	  List<SecteurActivite> secteursActivites = new ArrayList<>();
	  for(Integer idSA: idSecteursActivites) {
		  secteursActivites.add(secteurActiviteDAO.findById(idSA));
	  }
	  
	  offreEmploi.setSecteurActivites(new HashSet<SecteurActivite>());
	  for(SecteurActivite sA: secteursActivites) {
		  secteurActiviteDAO.update(offreEmploi.addSecteurActivite(sA));
	  }
	  offreEmploiDAO.persist(offreEmploi);
	  return offreEmploi;
	  
  }
  
  @Override
  public OffreEmploi miseAJourOffreEmploi(int id, String descriptif, String profilRecherche, String titre, int idEntreprise, int idNQualification, List<Integer> idSecteursActivites) {
	  OffreEmploi offreEmploi = offreEmploiDAO.findById(id);
	  offreEmploi.setTitre(titre);
	  offreEmploi.setDescriptifmission(descriptif);
	  offreEmploi.setProfilrecherche(profilRecherche);
	  niveauQualificationDAO.update(offreEmploi.setNiveauQualificationBean(niveauQualificationDAO.findById(idNQualification)).get(1));
	  niveauQualificationDAO.update(offreEmploi.setNiveauQualificationBean(niveauQualificationDAO.findById(idNQualification)).get(2));
	  
	  List<SecteurActivite> secteursActivites = new ArrayList<>();
	  for(Integer idSA: idSecteursActivites) {
		  secteursActivites.add(secteurActiviteDAO.findById(idSA));
	  }
	  
	  for(SecteurActivite sA: offreEmploi.getSecteurActivites()) {
		  sA.removeOffreEmploi(offreEmploi);
		  secteurActiviteDAO.update(sA);
	  }
	  
	  for(SecteurActivite sA: secteursActivites) {
		  secteurActiviteDAO.update(offreEmploi.addSecteurActivite(sA));
	  }
	  
	  return(offreEmploiDAO.update(offreEmploi));
	  
  }
  
  @Override
  public void effaceOffreEmploi(int id) {

  }
  
}
