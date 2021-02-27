package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.List;

import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreDemploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite;

public interface IServiceOffreEmploi {
	
	//-----------------------------------------------------------------------------
	  /**
	   * Obtention d'une <{@link OffreEmploi}.
	   * 
	   * @param id id de l'candidature à récupérer.
	   * @return
	   */
	  public OffreEmploi obtenirOffreEmploi(int id);
	  
	  /**
	   * Obtention de la liste de toutes les candidatures.
	   * 
	   * @return la Sete des candidatures dans une {@code Set<OffreEmploi>}.
	   */
	  public List<OffreEmploi> listeDesOffreEmplois();
	  
	  /*
	   * 
	   */
	  public  List<OffreEmploi> listeDesOffresPourUneEntreprise(int idEntreprise);
	  
	  /*
	   * 
	   */
	  public List<OffreEmploi> listeDesOffresPourUneCandidature(int idCandidature);
	  //-----------------------------------------------------------------------------
	  
	  /**
	   * 
	   */
	  public OffreEmploi nouvelleOffreEmploi(String descriptif, String profilRecherche, String titre, int idEntreprise, int idNQualification, List<Integer> idSecteursActivites);
	  
	  
	  /*
	   * 
	   */
	  public OffreEmploi miseAJourOffreEmploi(int id, String descriptif, String profilRecherche, String titre, int idEntreprise, int idNQualification, List<Integer> idSecteursActivites);
	  
	  /*
	   * 
	   */
	  public void effaceOffreEmploi(int id);
	  
}
