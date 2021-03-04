package eu.telecom_bretagne.cabinet_recrutement.data.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification;

/**
 * Session Bean implementation class NiveauQualificationDAO
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class NiveauQualificationDAO
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
  public NiveauQualificationDAO()
  {
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  public NiveauQualification findById(int id)
  {
    return entityManager.find(NiveauQualification.class, id);
  }
  //----------------------------------------------------------------------------
  @SuppressWarnings({ "rawtypes", "unchecked" })
  public List<NiveauQualification> findAll()
  {
    Query query = entityManager.createQuery("select niveauQualification from NiveauQualification niveauQualification order by niveauQualification.id");
    List l = query.getResultList(); 
    
    return (List<NiveauQualification>)l;
  }
  //-----------------------------------------------------------------------------
  public NiveauQualification persist(NiveauQualification niveauQualification) {
	  entityManager.persist(niveauQualification);
	  return niveauQualification;
  }
  
  public NiveauQualification update(NiveauQualification niveauQualification) {
	  entityManager.merge(niveauQualification);
	  return niveauQualification;
  }

}
