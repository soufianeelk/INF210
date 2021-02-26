package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.Set;

import javax.ejb.Remote;

import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreDemploi;

/**
 * Interface du service gérant les candidatures.
 * @author Philippe TANGUY
 */
@Remote
public interface IServiceCandidature
{
  //-----------------------------------------------------------------------------
  /**
   * Obtention d'une <{@link Candidature}.
   * 
   * @param id id de l'candidature à récupérer.
   * @return
   */
  public Candidature obtenirCandidature(int id);
  /**
   * Obtention de la Sete de toutes les candidatures.
   * 
   * @return la Sete des candidatures dans une {@code Set<Candidature>}.
   */
  public Set<Candidature> SeteDesCandidatures();
  
  /*
   * 
   */
  public Set<Candidature> SeteDesCandidaturesPourUneOffre(int idOffre);
  
  /*
   * 
   */
  public  Set<MessageOffreDemploi> SeteDesMessagesRecus(int idCandidature);
  
  /*
   * 
   */
  public Set<MessageCandidature> SeteDesMessagesEnvoyes(int idCandidature);
  //-----------------------------------------------------------------------------
  
  /**
   * 
   */
  public Candidature nouvelleCandidature(String adresseMail, String adressePostale, String cv, String nom, String prenom);
  
  
  /*
   * 
   */
  public Candidature miseAJourCandidature(int id, String adresseMail, String adressePostale, String cv, String nom, String prenom);
  
  /*
   * 
   */
  public void effaceCandidature(int id);
  
}
