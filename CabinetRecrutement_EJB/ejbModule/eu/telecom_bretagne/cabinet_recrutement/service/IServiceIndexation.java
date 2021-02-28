package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.List;

import javax.ejb.Remote;

import eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreDEmploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification;
import eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite;

/**
 * Interface du service gérant les entreprises.
 * @author Philippe TANGUY
 */
@Remote
public interface IServiceIndexation
{
  /**
   * Obtention de la liste de toutes les secteurs d'activité.
   * 
   * @return la liste des secteurs d'activité dans une {@code List<SecteurActivite>}.
   */
  public List<SecteurActivite> listeDesSecteursActivite();
  
  /**
   * Obtention de la liste de toutes les niveaux de qualification.
   * 
   * @return la liste des niveaux de qualification dans une {@code List<NiveauQualification>}.
   */
  public List<NiveauQualification> listeDesNiveauxQualification();
  

  
}
