

import java.util.List;

import javax.ejb.Remote;

import eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreDEmploi;

/**
 * Interface du service gérant les entreprises.
 * @author Philippe TANGUY
 */
@Remote
public interface IServiceEntreprise
{
  //-----------------------------------------------------------------------------
  /**
   * Obtention d'une <{@link Entreprise}.
   * 
   * @param id id de l'entreprise à récupérer.
   * @return
   */
  public Entreprise obtenirEntreprise(int id);
  /**
   * Obtention de la liste de toutes les entreprises.
   * 
   * @return la liste des entreprises dans une {@code List<Entreprise>}.
   */
  public List<Entreprise> listeDesEntreprises();
  
  /*
   * 
   */
  public  List<MessageCandidature> listeDesMessagesRecus(int idEntreprise);
  
  /*
   * 
   */
  public List<MessageOffreDEmploi> listeDesMessagesEnvoyes(int idEntreprise);
  //-----------------------------------------------------------------------------
  
  /**
   * 
   */
  public Entreprise nouvelleEntreprise(String nom, String adressePostale, String descriptif);
  
  
  /*
   * 
   */
  public Entreprise miseAJourEntreprise(int id, String nom, String adressePostale, String descriptif);
  
  /*
   * 
   */
  public void effaceEntreprise(int id);
  
}
