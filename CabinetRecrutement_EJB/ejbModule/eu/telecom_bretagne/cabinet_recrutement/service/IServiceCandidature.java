package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.Date;
import java.util.List;

import javax.ejb.Remote;

import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreDEmploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite;

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
   * Obtention de la liste de toutes les candidatures.
   * 
   * @return la Sete des candidatures dans une {@code Set<Candidature>}.
   */
  public List<Candidature> listeDesCandidatures();
  
  /*
   * 
   */
  public List<Candidature> listeDesCandidaturesPourUneOffre(int idOffre);
  
  /*
   * 
   */
  public  List<MessageOffreDEmploi> listeDesMessagesRecus(int idCandidature);
  
  /*
   * 
   */
  public List<MessageCandidature> listeDesMessagesEnvoyes(int idCandidature);
  //-----------------------------------------------------------------------------
  
  /**
   * 
   */
  public Candidature nouvelleCandidature(String adresseMail, String adressePostale, String cv, String nom, String prenom, String dateNaissance, String nQualification, List<String> idSecteursActivites);
  
  
  /*
   * 
   */
  public Candidature miseAJourCandidature(int id, String adresseMail, String adressePostale, String cv, String nom, String prenom, String dateNaissance, String nQualification, List<String> idSsecteursActivite);
  
  /*
   * 
   */
  public void effaceCandidature(int id);
  
}
