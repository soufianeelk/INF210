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
  public void nouvelleOffreEmploi(String descriptif, String profilRecherche, String titre, int idEntreprise, String nQualification, String[] idSecteursActivites) {
	  OffreEmploi offreEmploi = new OffreEmploi();
	  offreEmploi.setDatedepot(new Date());
	  offreEmploi.setTitre(titre);
	  offreEmploi.setDescriptifmission(descriptif);
	  offreEmploi.setProfilrecherche(profilRecherche);
	  Entreprise entreprise = offreEmploi.setEntrepriseBean(entrepriseDAO.findById(idEntreprise));
	  entrepriseDAO.update(entreprise);
	  int idNQualification = Integer.parseInt(nQualification);
	  niveauQualificationDAO.update(offreEmploi.setNiveauQualificationBean(niveauQualificationDAO.findById(idNQualification)));
	  
	  List<SecteurActivite> secteursActivites = new ArrayList<>();
	  
	  for(int i=0; i<idSecteursActivites.length; i++) {
		  int idSA = Integer.parseInt(idSecteursActivites[i]);
		  SecteurActivite sAC = secteurActiviteDAO.findById(idSA);
		  secteursActivites.add(sAC);
	  }
	  
	  offreEmploi.setSecteurActivites(new HashSet<SecteurActivite>());
	  for(SecteurActivite sA: secteursActivites) {
		  secteurActiviteDAO.update(offreEmploi.addSecteurActivite(sA));
	  }
	  offreEmploiDAO.persist(offreEmploi);
	  //return offreEmploi;
	  
  }
  
  @Override
  public OffreEmploi miseAJourOffreEmploi(int id, String descriptif, String profilRecherche, String titre, int idEntreprise, String nQualification, String[] idSecteursActivites) {
	  
			  
		  OffreEmploi offreEmploi = offreEmploiDAO.findById(id);
		  
		  offreEmploi.setTitre(titre);
		  offreEmploi.setDescriptifmission(descriptif);
		  offreEmploi.setProfilrecherche(profilRecherche);
		  
		  int idNQualification = Integer.parseInt(nQualification);
		  
		  NiveauQualification nQBean = offreEmploi.getNiveauQualificationBean();
		  nQBean.removeOffreEmploi(offreEmploi);
		  niveauQualificationDAO.update(nQBean);
		  
		  for(SecteurActivite sA: offreEmploi.getSecteurActivites()) {
			  sA.removeOffreEmploi(offreEmploi);
			  secteurActiviteDAO.update(sA);
		  }
		  
		  List<SecteurActivite> secteursActivites = new ArrayList<>();
		  
		  offreEmploi.setSecteurActivites(new HashSet<SecteurActivite>());
		  
		  for(String idSQ: idSecteursActivites) {
			  secteursActivites.add(secteurActiviteDAO.findById(Integer.parseInt(idSQ)));
		  }
		  
		  for(SecteurActivite sA: secteursActivites) {
			  secteurActiviteDAO.update(offreEmploi.addSecteurActivite(sA));
		  }
		  
		  return(offreEmploiDAO.update(offreEmploi));
		  
		  
		  

		/*  NiveauQualification oldNiveauQualification = offre.getNiveauQualificationBean();
		  NiveauQualification newNiveauQualification = niveauQualificationDAO.findById(nQualification);
		  SecteurActivite secteur = null;
		  
		  offre.setTitre(titre);
		  offre.setDescriptifmission(descriptifMission);
		  offre.setProfilrecherche(profilRecherche);
		  offre.setDatedepot(dateDepot);
		  
		  if (oldNiveauQualification!=null) {
		  oldNiveauQualification.removeOffreEmploi(offre);
		  }
		  
		  newNiveauQualification.addOffreEmploi(offre);

		  Set <SecteurActivite> listSA = new HashSet<>();
		  
		  for(SecteurActivite sA: offre.getSecteurActivites()) {
			  sA.getOffreEmplois().remove(offre);
			  secteurActiviteDAO.update(sA);
		  }
		  
		  for (Integer idSA : idSecteurActivite) {
			  listSA.add(secteurActiviteDAO.findById(idSA));
		  }
		  
		  for (SecteurActivite sA: listSA) {
			  secteurActiviteDAO.update(offre.addSecteurActivite(sA));
		}
		  
		  /*for (SecteurActivite sA : listSA) {
			  
			  if (offre.getSecteurActivites().contains(sA))	{
				  offre.getSecteurActivites().remove(sA);
			  }
			  
			  if (sA.getOffreEmplois().contains(offre)) {
				  sA.getOffreEmplois().remove(offre);
			  }

		  }
		  
		  for (SecteurActivite sA : offre.getSecteurActivites()) {
			  secteurActiviteDAO.update(sA);
		  }*

		  for (Integer idSA : idSecteurActivite) {
			  
			  secteur = secteurActiviteDAO.findById(idSA);
			  offre.getSecteurActivites().add(secteur);
			  secteurActiviteDAO.update(secteur);
			  
		  }*/

  }
  
  @Override
  public void effaceOffreEmploi(int id) {

  }
  
}
