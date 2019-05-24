/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package AutorizacaoDeAcesso;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Usuario;

/**
 *
 * @author alunocmc
 */
@WebFilter(urlPatterns = {"/principal.jsp"})
public class AcessoLogado implements Filter{
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException{
        
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException{
        HttpSession sessaoUsuario = ((HttpServletRequest)request).getSession();
        
        Usuario usuarioLogado = (Usuario)sessaoUsuario.getAttribute("usuarioAutenticado");
        
        if(usuarioLogado != null){
            chain.doFilter(request, response);
        } else {
            ((HttpServletResponse)response).sendRedirect("naoAutenticado.jsp");
        }
        
    }

    @Override
    public void destroy() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
