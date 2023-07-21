<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Permintaan_Temp extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();
        cek_login();

        $this->load->model('Admin_model', 'admin');
        $this->load->library('form_validation');
    }

    public function index()
    {
        $data['title'] = "Permintaan Barang";
        $data['permintaan_temp'] = $this->admin->getpermintaan_temp();
        $this->template->load('templates/dashboard', 'permintaan_temp/data', $data);
    }

    private function _validasi()
    {
        $this->form_validation->set_rules('tgl_req', 'Tgl Permintaan', 'required|trim');
        $this->form_validation->set_rules('barang_id', 'Barang', 'required');
        $this->form_validation->set_rules('jenis_id', 'Jenis', 'required');
        $this->form_validation->set_rules('jumlah', 'Jumlah', 'required|trim|numeric|greater_than[0]');
    }

    public function add()
    {
        $this->_validasi();
        if ($this->form_validation->run() == false) {
            $data['title'] = "Permintaan Barang";
            $data['barang'] = $this->admin->get('barang');
            $data['jenis'] = $this->admin->get('jenis');
            $data['permintaan_temp'] = $this->admin->getpermintaan_temp();

            // Mendapatkan dan men-generate kode transaksi pengajuan
            $kode = 'T-REQT-' . date('ymd');
            $kode_terakhir = $this->admin->getMax('permintaan_temp', 'id_req_temp', $kode);
            $kode_tambah = substr($kode_terakhir, -5, 5);
            $kode_tambah++;
            $number = str_pad($kode_tambah, 5, '0', STR_PAD_LEFT);
            $data['id_req_temp'] = $kode . $number;

            $this->template->load('templates/dashboard', 'permintaan_temp/add', $data);
        } else {
            // echo "<h2>dwdwdw</h2>";
            $input = $this->input->post(null, true);
            $insert = $this->admin->insert('permintaan_temp', $input);

            if ($insert) {
                set_pesan('data berhasil disimpan.');
                redirect('permintaan_temp/add');
            } else {
                set_pesan('Opps ada kesalahan!');
                redirect('permintaan_temp/add');
            }
        }
    }

    public function add_permintaan(){
        $data['permintaan_temp'] = $this->admin->getpermintaan_temp();
        // print_r( count($data['permintaan_temp']));
        for ($x = 0; $x < count($data['permintaan_temp']); $x++) {
            // print_r($data['permintaan_temp'][$x]['user_id']);
            $data01 = [
                'id_req'    => $data['permintaan_temp'][$x]['id_req_temp'],
                'barang_id' => $data['permintaan_temp'][$x]['barang_id'],
                'jumlah'    => $data['permintaan_temp'][$x]['jumlah'],
                'user_id'   => $data['permintaan_temp'][$x]['user_id'],
                'tgl_req'   => $data['permintaan_temp'][$x]['tgl_req']
            ];
            $insert = $this->admin->insert('permintaan', $data01);

            // print_r($data01['id_req']);
            $delete = $this->admin->delete('permintaan_temp', 'id_req_temp', $data01['id_req']);

            // $delete = $this->admin->delete('permintaan_temp', 'id_req_temp', $data01 = [
            //     'id_req_temp' => $data['permintaan_temp'][$x]['id_req_temp'],
            // ]);
        }

        if ($insert) {
            set_pesan('data berhasil disimpan.');
            redirect('permintaan_temp/add');
        } else {
            set_pesan('Opps ada kesalahan!');
            redirect('permintaan_temp/add');
        }

        // $input = $this->input->post(null, true);
        // print_r($input['user_id'][0]);
        // echo count($input);
        // for ($x = 0; $x < count($input); $x++) {
            // print_r($input['user_id'][$x][0][0][0][0]);
        // }
        // for ($x = 0; $x < count($input); $x++) {
        //     print_r($input);
        // }
        // echo "=======================================";
        // print_r($input['user_id']);
        // echo "=======================================";
        // foreach ($input as $item) {
        //     print_r($input['barang_id']);
        // }
    }

    public function detail_data()
    {
        $data['title'] = "Permintaan Barang";
        $data['permintaan_temp'] = $this->admin->getpermintaan_temp();
        $this->template->load('templates/dashboard', 'permintaan_temp/detail_data', $data);
    }

    public function delete($getId)
    {
        $id = encode_php_tags($getId);
        if ($this->admin->delete('permintaan_temp', 'id_req_temp', $id)) {
            set_pesan('data berhasil dihapus.');
        } else {
            set_pesan('data gagal dihapus.', false);
        }
        redirect('permintaan_temp');
    }
}