package eu.telecom_bretagne.cabinet_recrutement.data.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;

/**
 * Session Bean implementation class CandidatureDAO
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class CandidatureDAO
{
  //-----------------------------------------------------------------------------
  /**
   * Référence vers le gestionnaire de persistance.
   */
  @PersistenceContext
  EntityManager entityManager;
  //-----------------------------------------------------------------------------
  /**
   * Default constructor.
   */
  public CandidatureDAO()
  {
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  public Candidature findById(Integer id)
  {
    return entityManager.find(Candidature.class, id);
  }
  //----------------------------------------------------------------------------
  @SuppressWarnings({ "rawtypes", "unchecked" })
  public List<Candidature> findAll()
  {
    Query query = entityManager.createQuery("select candidature from Candidature candidature order by candidature.id");
    List l = query.getResultList(); 
    
    return (List<Candidature>)l;
  }
  //-----------------------------------------------------------------------------
  public Candidature persist(Candidature candidature) {
	  entityManager.persist(candidature);
	  return candidature;
  }
  
  public Candidature update(Candidature candidature) {
	  entityManager.merge(candidature);
	  return candidature;
  }
  
  public void remove(Candidature candidature) {
	  entityManager.remove(candidature);
  }
  
  public List<Candidature> findBySecteurActiviteAndNiveauQualification(int idSecteurActivite, int idNiveauQualification) {
	  Query query = entityManager.createQuery("select c from Candidature c join c.secteursActivite secteur " + 
			  								  "where secteur.id = :idSA and c.niveauQualification.id = :idNQ " +
			  								  "order by c.id desc");
	  query.setParameter("idSA", idSecteurActivite);
	  query.setParameter("idNQ", idNiveauQualification);
	  List<Candidature> l = query.getResultList();
	  return l;
  
  }	

}
