package eu.telecom_bretagne.cabinet_recrutement.data.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;

/**
 * Session Bean implementation class OffreEmploiDAO
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class OffreEmploiDAO
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
  public OffreEmploiDAO()
  {
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  public OffreEmploi findById(Integer id)
  {
    return entityManager.find(OffreEmploi.class, id);
  }
  //----------------------------------------------------------------------------
  @SuppressWarnings({ "rawtypes", "unchecked" })
  public List<OffreEmploi> findAll()
  {
    Query query = entityManager.createQuery("select offreEmploi from OffreEmploi offreEmploi order by offreEmploi.id");
    List l = query.getResultList(); 
    
    return (List<OffreEmploi>)l;
  }
  //-----------------------------------------------------------------------------
  public OffreEmploi persist(OffreEmploi offreEmploi) {
	  entityManager.persist(offreEmploi);
	  return offreEmploi;
  }
  
  public OffreEmploi update(OffreEmploi offreEmploi) {
	  entityManager.merge(offreEmploi);
	  return offreEmploi;
  }
  
  public void remove(OffreEmploi offreEmploi) {
	  if(!entityManager.contains(offreEmploi)) {
		  offreEmploi = entityManager.merge(offreEmploi);
	  }
	  entityManager.remove(offreEmploi);
  }
  
  public List<OffreEmploi> findByEntreprise(int idEntreprise)
  {
    Query query = entityManager.createQuery("select offreEmploi from OffreEmploi offreEmploi " +
                                            "where offreEmploi.entrepriseBean.id = :idE " +
                                            "order by offreEmploi.id desc");
    query.setParameter("idE", idEntreprise);
    List l = query.getResultList();
    return (List<OffreEmploi>)l;
  }
  
  public List<OffreEmploi> findBySecteurActiviteAndNiveauQualification(int idSecteurActivite, int idNiveauQualification) {
	  Query query = entityManager.createQuery("select oe from OffreEmploi oe join oe.secteurActivites sects " +
			  								  "where sects.id = :idSA and oe.niveauQualificationBean.id = :idNQ " +
			  								  "order by oe.id desc");
	  query.setParameter("idSA", idSecteurActivite);
	  query.setParameter("idNQ", idNiveauQualification);
	  List<OffreEmploi> l = query.getResultList();
	  return l;
  }

}
