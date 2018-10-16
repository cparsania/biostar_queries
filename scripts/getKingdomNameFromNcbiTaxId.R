## Biostar post : https://www.biostars.org/p/317073/#330335

#' Title : getKingdomNameFromNcbiTaxId
#' @description  : for a given vector of valid ncbi taxid retrieve corresponding kingdom id and kingdom name
#' @param inputTaxId : A vector of valid NCBI taxonomy ids 
#' @param n_threads  : A numeric value of maximumn number of threads used, default 3
#' @param ncbi_taxdir : Directory path containing ncbi taxonomy dump files
#'
#' @return : A data.frame with colanmes taxid, kingdom_id , sp_name
#' @export
#'
#' @examples

getKingdomNameFromNcbiTaxId <- function(inputTaxId , n_threads = 3 , ncbi_taxdir = "path/to/ncbi_taxonomy_files/"){
        
        ## load libraries 
        library("CHNOSZ")
        library("parallel")
        
        ## test variables 
        # inputTaxId <-  unique(mapped$staxid)
        # ncbi_taxdir = "/Users/chiragparsania/Documents/Projects/LiAng_Data/horizontal_gene_transfer/8_R/ncbi_taxonomy_files/"
        # n_threads = 6
        # 
        inputTaxId <- unique(inputTaxId)
        
        ## load NCBI taxonomy files 
        names <- getnames(taxdir = ncbi_taxdir)
        nodes <- getnodes(taxdir= ncbi_taxdir)
        
        ## parellal processing in mac 
        cl <- makeCluster(n_threads , type = "FORK")
        
        # iterate over each taxid 
        out <- parLapply(cl,inputTaxId, function(id){
                #id <- 2070412 ## test id 
                cat(paste("proc",id,"\n"))
                kingdom_id <- parent(id,taxdir,"kingdom",nodes)
                kingdom_name  <- sciname(kingdom_id,taxdir = taxdir,names = names)
                
        })
        stopCluster(cl)
        ## return object 
        final <- do.call("rbind",out)
        return(final)
}